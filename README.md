# 30ProjectsOfSwift

inspired by [allenwong/30DaysofSwift](https://github.com/allenwong/30DaysofSwift) and [soapyigu/Swift-30-Projects](https://github.com/soapyigu/Swift-30-Projects)<br/>

## Project Index & GIF Showcase
**Project-01 CountDownBar**

* CAShapeLayer&UIBezierPath

<img src="https://github.com/fnegdaq/Study-Swift/blob/master/Project-01%20CountDownBar/Jietu20190312-171327.gif" width="325" height="612" alt="project1"/> 


**Project-02 TumblrMenu**

* UIViewControllerAnimatedTransitioning & UIViewControllerTransitioningDelegate protocols

<img src="https://github.com/fnegdaq/Study-Swift/blob/master/Project-02%20TumblrMenu/Jietu20190314-114342.gif" width="325" height="612" alt="project1"/> 


**Project-03 MOO音乐**

看了一天音频相关，好复杂啊...  一些地方很难理解，还是得多学习～<br />
> For details please reference [potato04](https://juejin.im/post/5c1bbec66fb9a049cb18b64c)<br />

<img src="https://github.com/fnegdaq/Study-Swift/blob/master/Project-03%20MOO%E9%9F%B3%E4%B9%90/Jietu20190318-000107.gif" width="325" height="612" alt="project1"/> 


**Project-04 CollectionView**

* Custom UICollectionViewFlowLayout

<img src="https://github.com/fnegdaq/30ProjectsOfSwift/blob/master/Project-04%20CollectionView/Jietu20190325-220117.gif" width="325" height="612" alt="project1"/> 


**Project-05 SlideOutNavigation**

```func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil)```<br  />
这样的写法: ```((Bool) -> Void)? = nil``` <br  />
在使用的时候会变成两种方法可选： <br />
```func animateCenterPanelXPosition(targetPosition: CGFloat)```<br  />
```func animateCenterPanelXPosition(targetPosition: CGFloat, completion: (Bool) -> Void)```<br  />

oc中使用 __nullable ```completion:(void (^ __nullable)(BOOL finished))completion```

> For details please reference [raywenderlich](https://www.raywenderlich.com/1005187-how-to-create-your-own-slide-out-panel-navigation)<br />

<img src="https://github.com/fnegdaq/30ProjectsOfSwift/blob/master/Project-05%20SlideOutNavigation/Jietu20190329-114800.gif" width="325" height="612" alt="project1"/> 


**Project-05 HalfTunes**

- URLSession & URLSessionDownloadTask

```
try 出现异常, 使用 do catch 处理异常 
try? 不处理异常, 返回一个可选值类型, 出现异常返回 nil
try! 不让异常继续传播, 一旦出现异常程序停止, 类似 NSAssert()
```

> For details please reference [raywenderlich](https://www.raywenderlich.com/567)<br />

<img src="https://github.com/fnegdaq/30ProjectsOfSwift/blob/master/Project-06%20HalfTunes/Jietu20190329-214441.gif" width="325" height="612" alt="project1"/> 
