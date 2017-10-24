%hook SPTSearchHistory

- (unsigned long long)numberOfSavedSearchStrings {
return 0;
}

%end

@interface EXP_SPTSearchRecentsItemComponentView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook EXP_SPTSearchRecentsItemComponentView

-(void)layoutSubviews{

self.hidden = YES;

}

%end

@interface EXP_SPTSearchRecentsClearAllHubComponentView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook EXP_SPTSearchRecentsClearAllHubComponentView

-(void)layoutSubviews{

self.hidden = YES;

}

%end

%hook GLUELabel
-(void)setText:(NSString *)arg1{
if([arg1 isEqualToString:@"Recent searches"])
{
%orig(@" ");
} else {
%orig;
}
}
%end
