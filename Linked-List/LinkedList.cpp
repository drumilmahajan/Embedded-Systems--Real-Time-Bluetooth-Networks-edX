// Created by Drumil Mahajan, October 2016
// New York University, Tandon School of Engineering.

# include <iostream>


// Creating a node struct which will contain the key(data) and pointer
// to the next Node. 
struct Node {
	struct Node *next; //
	int key; // Payload of every node, which in our case is int.
	};
	
// typedef struct NodeType;
// This is required in C but not in C++ if creating a type is a requirement
// I could just type NodeType instead of struct Node in C. 
// In c++ i can call it Node without using the word struct. 

// Funtion to search a linked list. Search for int x in the list. 

int search(int x, Node *head_pt) {
	Node *pt; 
	pt = head_pt;
	
	// while pt goes travels the list until pt is 0 or NULL
	while(pt) {
		if(pt->key == x)
			return 1;
		pt = pt->next;	
	}
	return 0;
}

int main(void) {
	
	// Linked list can be defined statically and dynamically. Here
	// I am defining it statically. 
	
	// Creating an array of say 3 nodes. // A collection of nodes. Not linked right now.
	Node my_list[3];
	
	// Head pointer
	Node *head_pt;
	
	// POinter to any Node.
	Node *pt;
	
	// Creating first Node which contains the head pointer 
	// i.e. the address of mylist[1]
	my_list[0] = { &my_list[1], 2}; // 2 is just any int data for the linked list.
	
	// Creating second node which contains the address of third node
	my_list[1] = {&my_list[2] , 10}; 
	
	// Creating third node which is last no next pointer is NULL or 0.
	my_list[2] = { 0 , 100}; 
	
	// Putting address of my_list in head pointer a head pointer. 
	head_pt = my_list; // Can also be done as head_pt = &my_list[0]
	
	// To move pointer to any element. 
	// pt = pt->Next. // This means where ever the pt is right now.
	// Take its Next field and put it into pt. and the next filed contains the address
	// to the next Node. 
	
	int result = search(1, head_pt);
	
	std::cout<<"Result is :"<<result;
	
	}
