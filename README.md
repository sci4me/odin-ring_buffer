# odin-ring_buffer

This is just a simple, quickndirty implementation of a ring buffer. It does not take threading into consideration.

## Example Code:

```odin
package main

import "core:fmt"
using import "shared:odin-ring_buffer"

main :: proc() {
	rb := new(RingBuffer(8, int));

	for i in 1..5 do assert(offer(rb, i));

	fmt.println(rb);

	for i in 1..5 {
		v, ok := poll(rb);
		assert(ok);
		assert(v == i);
	}

	fmt.println(rb);

	v, ok := poll(rb);
	assert(!ok);

	for i in 1..8 do assert(offer(rb, 1 << uint(i)));

	fmt.println(rb);

	assert(!offer(rb, 42));
	assert(size(rb) == 8);
	assert(full(rb));
	assert(!empty(rb));
}
```