//
//  ViewController.m
//  1.运行时
//
//  Created by Elaine on 16--2.
//  Copyright © 2016年 yinuo. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self runtimeTest];
    [self runTimeTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 1
/**
 *  运行时练习
 */
- (void)runtimeTest
{
    [self performSelector:@selector(doSomething)];
}

#pragma mark - 对象在收到无法解读的消息后，首先会调用
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(doSomething)) {
        
        NSLog(@"----add Method Here");
        
        //  添加doSomething方法
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

void dynamicMethodIMP (id self, SEL _cmd) {
    NSLog(@"doSomething SEL");
}

#pragma mark - 2
- (void)runTimeTest
{
    [self performSelector:@selector(secondVCMethod)];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    Class class = NSClassFromString(@"CBSecondViewController");
    UIViewController *vc = class.new;
    
    if (aSelector == NSSelectorFromString(@"secondVCMethod")) {
        NSLog(@"secondVC do it!");
        
        return vc;
    }
    
    return nil;
}

@end
