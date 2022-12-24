from random import randint, choice
import time
start = time.time()
f = open('text.txt', 'w')
listOfRus = 'абвгдежзийклмнопрстуфхцчшщъыьэюяё-'
listOfEng = 'abcdefghijklmnopqrstuvwxyz-'
letter = ''
ans = ''
for i in range(10000000):
  length = randint(1, 10)
  for j in range(length):
    if j % 2 == 0:
      letter = choice(listOfRus)
    else:
      letter = choice(listOfEng)
    ans += letter
  f.write(ans + ' ')
  ans = ''
f.close()
print("%s seconds" % (time.time() - start))

