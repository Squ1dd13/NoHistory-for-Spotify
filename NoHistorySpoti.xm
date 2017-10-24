%hook SPTSearchHistory
//For older versions of Spotify
- (unsigned long long)numberOfSavedSearchStrings {
return 0;
}

%end

//From 8.4.22.515 and up, we need to hide the 'Clear Recent Searches' button and the actual history.

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

//Because there are GLUELabels throughout the app, we need to find a one that displays 'Recent searches' and change it to a space ( ).

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
