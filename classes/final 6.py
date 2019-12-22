total = 3
for i in range(1, 3):
 for j in range(1, 4):
     print(j, "*", total, "+ 2 *", i)
     total = j*(total+2*i)
print(total)
