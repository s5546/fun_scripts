
# 5*x*c[x-2]+3*c[x-1]
memes = []
for i in range(0,10):
    if i == 0:
        memes.append(1)
    elif i == 1:
        memes.append(3)
    else:
        value = 5*i*memes[i-2]+3*memes[i-1]
        memes.append(value)
print(memes)
