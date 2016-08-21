# react-elem

> Simpler elements without JSX

Example:

```javascript
import {DOM} from 'react-elem';
const {div, p, h1, ul, li, a} = DOM;

export default () => {
  return div(
    h1('Welcome!'),
    p("to react-elem"),
    ul(
      li(a({href:"https://github.com/algesten/react-elem"}, "github.com/algesten/react-elem")),
      li(a({href:"https://github.com/algesten/refnux"}, "another cool project"))
    )
  );
}
```


### No or multiple property objects

All property objects are merged into one.

```javascript
div({className:"mydiv"}, {key:"special1"}) // equivalent to
div({className:"mydiv", key:"special1"})   // this
```


### Text anywhere

Order doesn't matter

```javascript
div({id:"mydiv"}, "Hello!") // equivalent to
div("Hello!", {id:"mydiv"}) // this
```


### Varags elements

```javascript
ul(li("One"), li("Two"), li("Three"))
```


### Function to encapsulate children

Captures nested created elements.

```javascript
ul(() => {
    li("One")
    li("Two")
    li("Three")
})
```


#### ISC License (ISC)

Copyright (c) 2016, Martin Algesten <martin@algesten.se>

Permission to use, copy, modify, and/or distribute this software for
any purpose with or without fee is hereby granted, provided that the
above copyright notice and this permission notice appear in all
copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
