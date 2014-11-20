#!/Library/Frameworks/Python.framework/Versions/2.7/bin/python
import sys
from numpy import *
from pylab import *
from matplotlib.ticker import AutoMinorLocator
import re

if len(sys.argv) < 2:
  print "Invalid arguments"
  exit()

i = 2

while i < len(sys.argv):
  filename = sys.argv[i]
  print "Reading " + filename 
  if sys.argv[1] == 'w':
    array = genfromtxt(filename, delimiter=',')
  else:
    array = genfromtxt(filename, delimiter='	')

  array = transpose(array)

  if sys.argv[1] == 'i':
    plot(array[0],array[1], label=filename[:-4].replace('_',' '))
  elif sys.argv[1] == 'n':
    amax = array[1].max()
    print amax
    for j,cell in enumerate(array[1]):
      if cell != 0:
        array[1][j] = cell / amax
    plot(array[0],array[1], label=filename[:-4].replace('_',' '))

  elif sys.argv[1] == 'w':
    plot(array[0],array[1], label=filename[:-4].replace('_',' '))
  elif sys.argv[1] == 't':
    search = re.search('([0-9]+)[s]', filename);
    inttime = int(search.group(1))
    for j,cell in enumerate(array[1]):
      if cell != 0:
        array[1][j] = cell / inttime
    plot(array[0],array[1], label=filename[:-4].replace('_',' '))
  i+=1


if sys.argv[1] == 'w':
  xlabel('Excitation power (mW)', fontweight="bold")
else:
  xlabel('Wavelength (nm)', fontweight="bold")
  
if sys.argv[1] == 'i':
  ylabel('Intensity (counts)', fontweight="bold")
elif sys.argv[1] == 'n':
  ylabel('Normalized intensity', fontweight="bold")
elif sys.argv[1] == 'w':
  ylabel('Peak intensity (counts)', fontweight="bold")
elif sys.argv[1] == 't':
  ylabel('Intensity (counts/s)', fontweight="bold")

#title('')

legend(loc=2)

ax = axes()
ax.yaxis.tick_left()
ax.xaxis.tick_bottom()

#increase major linewidth

ax.yaxis.set_minor_locator(AutoMinorLocator(5))
ax.xaxis.set_minor_locator(AutoMinorLocator(5))

grid(True, 'major', linewidth=1.5)
grid(True, 'minor')
show()
