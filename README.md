Simple project timers. Start with `ruby -Ilib lib/devtimer.rb`.
Hacked together on ruby 1.9.3.

Inside the irb shell, you have access to the timers array `timers` and
the current timer `timer`. Most timer actions are delegated from `timers` to
`timer`. This is what a session might look like:

    irb(main):001:0> timers.new "Clientwork" #becomes current timer since there is none yet
    => (  1) Clientwork:         0h  0'  0.0'',      stopped. (current)
    irb(main):002:0> timer.start
    => (  1) Clientwork:         0h  0'  0.0'',      running! (current)
    # ... hack on ...
    irb(main):003:0> timer.stop
    => (  1) Clientwork:         0h 23' 42.5'',      stopped. (current)

I got interrupted by a phone call and forgot to log this.
The call lasted about 20 minutes, so:

    irb(main):004:0> timer.add 20.minutes
    => (  1) Clientwork:         0h 43' 42.5'',      stopped. (current)

In case you inquire what you did:

    irb(main):005:0> timer.log
    => (  1) Clientwork:         0h 43' 42.5'',      stopped. (current)
    Timer started at 2012-08-10 at 12:34
    Timer stopped at 2012-08-10 at 12:58
    Added 1200 seconds at 2012-08-10 at 13:31

You can have more than one timer:

    irb(main):006:0> timers.new "Homework"
    => (  2) Homework:           0h  0'  0.0'',      stopped.
    irb(main):007:0> timers.switch_to 2
    => (  2) Homework:           0h  0'  0.0'',      stopped. (current)
    irb(main):008:0> timers
    => Timers:
    (  1) Clientwork:         0h 43' 42.5'',      stopped.
    (  2) Homework:           0h  0'  0.0'',      stopped. (current)

To get out of the shell, you need to stop the current timer, if running, and
delete all timers.

    irb(main):009:0> timer.delete
    => (  2) Homework:           0h  0'  0.0'',      stopped.
    irb(main):010:0> timers.delete_all
    => No timers defined! Use timers.new 'name' to create one.
    irb(main):011:0> exit
