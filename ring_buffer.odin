package main

import "core:math/bits"

RingBuffer :: struct(N: int, T: typeid) where N > 0 && (N & (N - 1)) == 0 {
	data: [N]T,
	read: int,
	write: int
}

size :: inline proc(using rb: ^RingBuffer($N, $T)) -> int {
	return write - read;
}

full :: inline proc(using rb: ^RingBuffer($N, $T)) -> bool {
	return size(rb) == N;
}

empty :: inline proc(using rb: ^RingBuffer($N, $T)) -> bool {
	return size(rb) == 0;
}

offer :: proc(using rb: ^RingBuffer($N, $T), value: T) -> bool {
	if full(rb) do return false;

	data[write & (N - 1)] = value;
	write += 1;

	return true;
}

poll :: proc(using rb: ^RingBuffer($N, $T)) -> (T, bool) {
	if empty(rb) {
		dummy : T;
		return dummy, false;
	}

	result := data[read & (N - 1)];
	read += 1;

	return result, true;
}