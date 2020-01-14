# 

# title
## title


``` swift
 private func doInitialTask() throws {
        // network check
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            throw GuiaError.networkUnavailable
        }
        
        if LegacyConfig.hasPreferencesData() {
            // preference는 서버통신이 필요 없으으로 먼저 migration 한다
            // 또한, preference 이외의 data migrations 시(startMigration())에는 SettingModel.userItem 객체가 이미 생성되어 있어야 하므로
            // *반드시* startMigration이 호출되기 이전에 실행되어야 한다.
            MigrationService.importLegacyPreferences()
        }
        
        GPlaceManager.instance.retryHandlerProvider = { return GuiaPlaceRetryHandler() }
        GNavigationManager.instance.retryHandlerProvider = { return GuiaNaviRetryHandler() }
        GNavigationManager.instance.controlTimeCheckDelegate = GuiaControlTimeChecker()
        
        //gateway initial tasks
        if AppExtraOptions.instanceId == nil {
            gatewayModel.registerInstance(twKey: LegacyConfig.twKey)
        } else {
            // 이미 instance id 존재함. token request
            gatewayModel.requestToken()
        }
        
        if MigrationService.hasMigrationData() {
            self.migrationService = MigrationService()
            self.migrationService?.delegate = self
        }
    }
```