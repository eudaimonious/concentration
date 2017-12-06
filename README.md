# concentration
First homework project from Stanford CS193P. 

With all cards initially face-down, flip them over one by one in an attempt to match each pair of cards.

## consists of
- a Concentration struct
- a Card struct
- a view controller
- a storyboard

## feedback

This is my first iOS/Swift project. It was built under some constraints presented by the instructor meant to exercise specific initial learnings.
* The instructor specified that Card should be a struct. I believe if it was a class instead I could compare and update objects and remove a lot of these subscripts into the cards array by index. Do you agree? Is that a more desirable solution?
* The scoring algorithm isn't perfect but I don't really care about that.
* Swift Guides made it seem like my viewDidLoad method in the controller should call super.init() before doing other stuff. But this works without doing that. Hmmm.
* I really don't know what I'm doing in terms of ordering properties and methods in a file. Is there a best practice?
* Any other stuff to point out?

## looks like

![](https://i.imgur.com/rLWsWEo.png)
![](https://i.imgur.com/ZJV4oji.png)
