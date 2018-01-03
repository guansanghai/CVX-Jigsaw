# CVX-Jigsaw

Solving [jigsaw puzzles](https://en.wikipedia.org/wiki/Jigsaw_puzzle) using Matlab and [CVX](http://cvxr.com) toolbox (THU Convex Optimization Homework).

## Contributors

关桑海（电子系），丁瑞金（自动化系）.

## Platform

* _Matlab_: R2016b or higher
* _CVX Toolbox_: version 2.1 or version 3.0 beta _(recommended)_ or higher

## Sample

### LP Solve

A jigsaw puzzle with 3300 pieces

![Jigsaw puzzle with 3300 pieces](/Sample/LP/5a.jpg)

The restored image (LP method + greedy filling)

![Restored image](/Sample/LP/5c.jpg)

### QP Solve

A jigsaw puzzle with 25 pieces

![puzzle](/Sample/QP/lena-0.jpg)

After 1 iteration

![lena-1](/Sample/QP/lena-1.jpg)

After 2 iterations

![lena-2](/Sample/QP/lena-2.jpg)

After 3 iterations

![lena-3](/Sample/QP/lena-3.jpg)

After 4 iterations

![lena-4](/Sample/QP/lena-4.jpg)

After 5 iterations (the restored image)

![lena-5](/Sample/QP/lena-5.jpg)

## References

1. R. Yu, C. Russell, L. Agapito, "Solving Jigsaw puzzles with linear programming" [PDF](https://arxiv.org/abs/1511.04472)

2. F. A. Andalo, G. Taubin, S. Goldenstein, "PSQP: Puzzle solving by quadratic programming," IEEE Transactions on Pattern Analysis and Machine Intelligence, vol. 39, no. 2, pp. 385-396, 2017. [PDF](http://ieeexplore.ieee.org/document/7442162/)

3. A. C. Gallagher, "Jigsaw puzzles with pieces of unknown orientation," 2012 IEEE Conference on Computer Vision and Pattern Recognition, Providence, RI, 2012, pp. 382-389. [PDF](http://ieeexplore.ieee.org/document/6247699/)

4. CVX: Matlab Software for Disciplined Convex Programming. [Download](http://cvxr.com/cvx/)

5. Computational Jigsaw Puzzle Solving. [Website Link](http://icvl.cs.bgu.ac.il/automatic-jigsaw-puzzle-solving/)
