// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;
contract Counter {
    event Incremented(bool indexed odd, uint x);
	event Created(uint x);
	event Valued(uint x);
	
    constructor(){
        x = 70;
		emit Created(x);
    }
    
    function increment() public{
        x+=1;
        emit Incremented(x % 2 == 1, x);
    }
	
    function getValue() public returns (uint) {
		emit Valued(x);
        return x;
    }

    uint x;
}

contract Creator {
	Counter counter;
	event CounterCreated(uint);
	
	constructor() {
		counter = new Counter();
		emit CounterCreated(counter.getValue());
	}
}
