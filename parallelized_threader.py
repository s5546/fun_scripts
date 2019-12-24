# runs the given file in python 2.x
# opens one copy for each core
# depending on the script this can require

# i personally use this as a companion script for other python programs, ones that use an integer value for args[1]
import logging
import threading
import time
import os
import sys
import multiprocessing



# func:	script_launcher
# in:	the path of a python 2.x file to run (string) and the value to pass in (any str-convertable datatype)
# out:	n/a
# desc:	Launches a new instance of the given python thread.
#	Important to note this isn't a child or a fork- its an independent process with no communication to the threader process
def script_launcher(file, arg_value):
    start_time = time.time()
    command = 'python ' + file +  ' ' + str(arg_value)
    global currentJobs
    currentJobs = currentJobs + 1
    os.system(command)
    currentJobs = currentJobs - 1
    #print("thread %d took %f seconds to execute" % (arg_value, time.time() - start_time))

# func:	status_printer
# in:	n/a
# out:	n/a
# desc:	prints how many jobs are running, how many jobs have ran, and how many jobs will run, in that order.
#	formatted like this: 23/100 | 12
#	(assuming 23 jobs ran, 100 overall, with 12 running currently)
def status_printer():
    start_time = time.time()
    global currentJobs
    global i
    global max_args
    while i < max_args:
        os.system("clear")
        print("Started @ " + time.ctime(start_time) + " UTC\nCurrent Status (updates every 10 seconds):\n" + str(currentJobs) + " | " + str(i) + "/" + str(max_args))
        time.sleep(10)
try:
    choice = sys.argv[1]
except IndexError:
    choice = raw_input("name of python file to run\n>")
print('launching: ', choice)
jobs = []
print("main  : creating threads")
#1000000 is an arbitrary number, you do you
max_args = 1000000
for x in range(1,max_args):
    jobs.append(threading.Thread(target=script_launcher, args=(choice, x,)))
print("main  : threads created")
print("main  : starting threads")
currentJobs = 0
i = 0
status = threading.Thread(target=status_printer)
status.start()
# while there's still jobs left,
while i < max_args:
    # if there are free cores avaliable,
    if currentJobs < multiprocessing.cpu_count():
	# open a new job for each free core
        for j in range(multiprocessing.cpu_count() - currentJobs):
            jobs[i].start()
            i = i + 1
print("main  : all threads created, all done")
