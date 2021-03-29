import os
os.chdir("E:\\Class Archive\\CYBER440\\final proj\\forensics\\!! memes")
filecounter = 0
with open("0467807", "rb") as f:
    while (byte := f.read(1)):
        if byte == b"\x4D": # if you find M
            if (f.read(1) == b"\x5A"):
                
                bytes_lastblock = int.from_bytes(f.read(2), byteorder='little') # read bytes 02 and 03, which contains how many bytes are in the last block
                if bytes_lastblock == 0:
                    bytes_lastblock = 512
                blocks_in_exe = int.from_bytes(f.read(2), byteorder='little') # read bytes 04 and 05, which contains how many blocks are used (each block is 512 bytes)
                tempbyte = f.read(111)
                if b"\x68\x69\x73\x20\x70\x72\x6F\x67\x72\x61\x6D\x20\x63\x61\x6E\x6E\x6F\x74\x20\x62\x65\x20\x72\x75\x6E\x20\x69\x6E\x20\x44\x4F\x53\x20\x6D\x6F\x64\x65\x2E" in tempbyte:
                    print("YEHAW WE FOUND OURSELVES A PROGRAM")
                    print(bytes_lastblock, blocks_in_exe)
                    with open(str(filecounter) + ".exe", "wb") as newfile:
                        filecounter += 1
                        emptybytes = 0
                        f.seek(-117, 1)
                        while (blocks_in_exe > 0):
                            if blocks_in_exe == 1:
                                newfile.write(f.read(bytes_lastblock))
                                blocks_in_exe = 0
                                break
                            newfile.write(f.read(512))
                            blocks_in_exe -= 1


    

# 4D 5A


    '''
This program cannot be run in DOS mode. : 546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E

    '''
    '''graveyard
        if byte == b"\x54": # if you find byte value 54
            fullbyte = f.read(38)    # if you find the rest of the string
            if fullbyte == b"\x68\x69\x73\x20\x70\x72\x6F\x67\x72\x61\x6D\x20\x63\x61\x6E\x6E\x6F\x74\x20\x62\x65\x20\x72\x75\x6E\x20\x69\x6E\x20\x44\x4F\x53\x20\x6D\x6F\x64\x65\x2E":
                print("YEHAW WE FOUND OURSELVES A PROGRAM")
                with open(str(filecounter) + ".exe", "wb") as newfile:
                    filecounter += 1
                    emptybytes = 0
                    f.seek(-117, 1)
                    while (byte := f.read(1)):
                        newfile.write(byte)
                        if (emptybytes > 64):
                            break
                        elif byte == b"\x00":
                            emptybytes += 1
                        else:
                            emptybytes = 0
    '''