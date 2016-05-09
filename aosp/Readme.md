An addendum to Kyle Manna's aosp container.
I add Oracle java6 so I can compile for Gingerbread.
Note that there is at least one other file required to use this container properly,
the "aosp" script. See the readme for Kyle's container here:
https://github.com/kylemanna/docker-aosp/raw/master/README.md

Note that Java 6 is the default. So to switch to another, use:

sudo update-alternative --config java

