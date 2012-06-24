# Oh, behave!

*Behavior Trees library written in CoffeeScript*


## What are behavior trees?

The behavior tree (BT) technique is a novel approach to game AI that merges the core behavior tree qualities of several popular technologies. Plainly put, BTs are a compromise between FSMs, HTN planners and scripting. Although the BT technique is ﬁrmly rooted in FSMs and HFSMs, it does not have a single historical precedence.

It has emerged as a way of easing the modeling of purposeful action selection for agent-based behavior. Although it is a relatively new technology, it has gained widespread popularity and recognition in the game industry. It has been used in popular and critically acclaimed games such as Halo 2, Spore and Grand Theft Auto: San Andreas.

So what is a behavior tree actually? In simpliﬁed terms, a behavior tree may be regarded as a HFSM where the transitions are implicitly handled by special nodes that impose an ordering and ﬂow of control among its children. 

The actual implementation of the behaviors is hidden in the composition of the subtrees, allowing the designer to focus on the appropriate level of abstraction. Selecting which behavior to perform is the responsibility of the parent node. This selection will often depend on observations in the world.

One thing that sets behavior trees signiﬁcantly apart from standard HFSMs is that transitions between nodes do not need to be explicitly deﬁned. Handling of transitions are built directly into the hierarchical structure of behavior trees. Action selection is performed by searching through the tree. The search traverses the tree and the nodes guide the direction of the search and thus help to select relevant actions. The search is intuitive as only a few distinct types of search-guiding nodes are needed and each has a speciﬁc purpose.

I wrote my [Master's Thesis](https://docs.google.com/viewer?a=v&pid=sites&srcid=ZGVmYXVsdGRvbWFpbnxiZWhhdmlvcnRyZWVlZGl0b3J8Z3g6NzZiNDU2OWY0MTRlODUzYQ) in Computer Science on the subject. For more information see the [project site](https://sites.google.com/site/behaviortreeeditor/) for my Master's Thesis.


## Development roadmap

* Create a very simple example of Sequence, Selector and a few primitive Tasks
* Implement a few game related extension tasks
* * MoveAction (movement on a 2D surface)
* ?
* Make a more extensive example of using behavior trees (maybe as a different project?)
* Profit!


## Getting Started
_(Coming soon)_


## Examples
_(Coming soon)_


## Release History
_(Nothing yet)_

## License
Copyright (c) 2012 Anders Nissen  
Licensed under the MIT license.
