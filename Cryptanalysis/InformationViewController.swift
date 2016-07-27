//
//  InformationViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 13/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation
import UIKit


class InformationViewController: UIViewController, UIPageViewControllerDataSource {
    var pageViewController: UIPageViewController!
    var stasticalModel : StasticalModel = StasticalModel()
    var frequencyLabel = ["Monogram","Bigram","Trigram"]
    override func viewDidLoad() {
        super.viewDidLoad()
        putToPageView()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {putToPageView()
    }
    
    func putToPageView(){
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        let startVC = self.viewControllerAtIndex(0) as InformationContentViewController
        let viewControllers = NSArray (object: startVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height - 0)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndex( index: Int) -> InformationContentViewController{
        let vc: InformationContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! InformationContentViewController
        stasticalModel.generateChart(index+1, isCaseSensitive: false, isRemoveSymbol: true)
        vc.content = stasticalModel.getStaticalInformation()
        vc.pageIndex = index
        vc.frequencyContent = frequencyLabel[index]
        vc.monoOrPolyContent = String(stasticalModel.calIC(stasticalModel.getTrimmedText()))
        return vc
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! InformationContentViewController
        var index = vc.pageIndex as Int
        
        
        if (index == 0 || index == NSNotFound){
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! InformationContentViewController
        var index = vc.pageIndex as Int
        if(index == NSNotFound)
        {
            return nil
        }
        index += 1
        if (index >= 3)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}