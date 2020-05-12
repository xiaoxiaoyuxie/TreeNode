//
//  OrganizationViewController.m
//  TimeDBModule
//
//  Created by 杨永强 on 2020/4/17.
//

#import "OrganizationViewController.h"
#import "OrganizScrollView.h"
#import "OrganizationView.h"

@interface OrganizationViewController ()
@property(nonatomic, strong) OrganizScrollView *editView;
@end

@implementation OrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _editView = [OrganizScrollView new];
    [self.view addSubview:_editView];

    OrganizationModel *model = [OrganizationModel new];
    model.title = @"root";
    self.editView.rootOrgView = [[OrganizationView alloc] initWithModel:model];
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _editView.frame = self.view.bounds;
}

@end
