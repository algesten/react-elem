
# Turns a react element into something more palatable.
# I.e.
# React.DOM.p null, 'panda'
# becomes
# DOM.p 'panda'

# not null object?
isobject   = (o) -> !!o && typeof o == 'object' && !Array.isArray(o)

# taken from react source code
`var REACT_ELEMENT_TYPE = (typeof Symbol === 'function' && Symbol.for && Symbol.for('react.element')) || 0xeac7`

# is a react element?
isValidElement = (o) -> o.$$typeof == REACT_ELEMENT_TYPE

# is a plain property?
isprop     = (o) -> isobject(o) and not isValidElement(o)

# string?
isstring   = (s) -> typeof s == 'string'

# function?
isfunction = (f) -> typeof f == 'function'

# is a child?
ischild    = (c) -> isValidElement(c) or isfunction(c) or Array.isArray(c)

# mixin objects
mixin     = (os...) -> t = {}; t[k] = v for k,v of o for o in os; t

# singleton capture for children in function wrappers
capture = []

# helper to wrap a capture
wrapCapture = (fn) -> (as...) ->
    ret = fn as...
    if capture.length
        capture[0].push ret
        undefined
    else
        ret

wrap = (fn) -> wfn = wrapCapture(fn); (as...) ->

    # find all plain properties and merge them
    # i.e. we can do: div {class:'blah'}, {id:'foo'}
    propsas = as.filter isprop
    props = switch propsas.length
        when 0 then null
        when 1 then propsas[0]
        else mixin propsas...

    # coffee is ok with class as prop name
    if props?.class
        props.className = props.class
        delete props.class

    # gather all strings
    strnas = as.filter isstring
    strn = switch strnas.length
        when 0 then null
        when 1 then strnas[0]
        else strnas.join('')

    # all child functions, arrays, and plain elements
    # together to keep the order
    childsarr = as.filter(ischild).map (c) ->
        if isfunction(c)
            capture.unshift [] # push stack
            c()
            capture.shift()    # pop stach
        else
            [c]

    # unwrap [[a], [b], [c,d]] to [a,b,c,d]
    childs = [].concat childsarr...

    # invoke actual factory function
    wfn props, strn, childs...



# helper to wrap all values in an object
# i.e. DOM = wrapall React.DOM
wrap.wrapall = (o) -> t = {}; t[k] = wrap(v) for k, v of o when isfunction(v); t

# attempt to find react and expose the React.DOM wrapped
try
    React = require 'react'
    # expose all of reacts DOM
    wrap.DOM = wrap.wrapall React.DOM
catch
    console?.warn 'No React for react-elem. Failed to expose DOM', err

# ship it
module.exports = wrap
