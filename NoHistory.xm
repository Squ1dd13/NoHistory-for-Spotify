static BOOL enable;
static NSDictionary *preferences = nil;

%hook SPTSearchHistory

- (unsigned long long)numberOfSavedSearchStrings {
    if (enable) {
        return 0;
    }
}
%end

@interface EXP_SPTSearchRecentsItemComponentView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook EXP_SPTSearchRecentsItemComponentView


-(void)layoutSubviews{
    if (enable) {
        self.hidden = YES;
        
    }
}
%end

@interface EXP_SPTSearchRecentsClearAllHubComponentView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end

%hook EXP_SPTSearchRecentsClearAllHubComponentView

-(void)layoutSubviews{
    if (enable) {
        self.hidden = YES;
        
    }
}
%end
%hook GLUELabel

-(void)setText:(NSString *)arg1{
    if (enable){
        if([arg1 isEqualToString:@"Recent searches"])
        {
            %orig(@" ");
        } else {
            %orig;
        }
    }
}
%end

%hook UITableViewLabel

-(void)setText:(NSString *)arg1{
    if (enable){
        if([arg1 isEqualToString:@"8.4.22.515"])
        {
            %orig(@"8.4.22.515/NoHistory 1.3");
        }
        else if([arg1 isEqualToString:@"8.4.24.506"])
        {
            %orig(@"8.4.24.506/NoHistory 1.3.1");
        } else {
            %orig;
        }
    }
}
%end

static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.squ1dd13.nohistoryprefs.plist"];
    if(prefs)
    {
        enable = ( [prefs objectForKey:@"enable"] ? [[prefs objectForKey:@"enable"] boolValue] : enable );
        [prefs release];
    }
}

%ctor
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.squ1dd13.nohistoryprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}

