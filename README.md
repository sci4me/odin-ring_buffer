# odin-ring_buffer

This is just a simple, quickndirty implementation of a ring buffer. It does not take threading into consideration.

## Example Code:

```odin
package main

import "core:fmt"
using import "shared:odin-ring_buffer"

main :: proc() {
	rb := new(RingBuffer(8, int));

	{
		for i in 1..5 do assert(offer(rb, i));
	}

	fmt.println(rb, "\n");

	{
		for i in 1..5 {
			v, ok := poll(rb);
			assert(ok);
			assert(v == i);
		}
	}

	fmt.println(rb, "\n");

	{
		v, ok := poll(rb);
		assert(!ok);
		
		for i in 1..8 do assert(offer(rb, 1 << uint(i)));
	}

	fmt.println(rb, "\n");

	{
	    assert(!offer(rb, 42));
		assert(size(rb) == 8);
		assert(full(rb));
		assert(!empty(rb));
	}

	{
		a := []int{1, 3, 4, 7, 11};
		assert(offer_many(rb, a) == len(a));
	}

	fmt.println(rb, "\n");

	{
		buf := make([]int, 4);
		defer delete(buf);

		assert(poll_many(rb, &buf, 0, 4) == len(buf));

		assert(buf[0] == 1);
		assert(buf[1] == 3);
		assert(buf[2] == 4);
		assert(buf[3] == 7);
	}

	fmt.println(rb, "\n");

	{
		buf := make([]int, 4);
		defer delete(buf);

		assert(poll_many(rb, &buf, 0, 4) == 1);
		assert(buf[0] == 11);
		assert(buf[1] == 0);
		assert(buf[2] == 0);
		assert(buf[3] == 0);
	}

	fmt.println(rb, "\n");
}
```