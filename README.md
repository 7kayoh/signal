# signal

Signal is a simple signal and slots (or known as listeners) implementation in Lua, created by 7kayoh.

It is to replicate the concept of signal so it can be applied to Lua applications for maximum performance and efficiency compared to other methods (such as, yielding).

## Benefits of using signals

- It's much performant -- yielding is deemed as a bad coding practice in most of the situations and applications who demand performance should generally avoid yielding in code
- ~0ms delay -- yielding is usually done with while loops and a stack overflow could potentially occur without any sort of waiting, as a result, states can be only detected after a few of unnecessary milliseconds, where signal does produce barely any delay (linear time)
- Modern abstraction -- if you have touched other programming languages, you may have touched an abstraction called events, signal is basically the origin of events!

## Performance

Compared to majority of the signal libraries in Lua, the listeners here are stored inside a dictionary, where every listener is given an unique identifier for faster disconnection (no linear time)
However, as the listeners are stored inside a dictionary, the size of the dictionary will be a bit larger than regular tables. You should generally avoid this if you are running this in limited resources.

Only the emitting part produces a linear time

## API Reference

Read the top comment of the module

## License

Licensed under the MIT license
