public enum Command: String {
    // connection messages
    case capabilities = "CAP"
    case authenticate = "AUTHENTICATE"
    case password = "PASS"
    case nickname = "NICK"
    case user = "USER"
    case ping = "PING"
    case pong = "PONG"
    case becomeOperator = "OPER"
    case quit = "QUIT"
    case fatalError = "ERROR"

    // channel commands
    case join = "JOIN"
    case part = "PART"
    case topic = "TOPIC"
    case names = "NAMES"
    case list = "LIST"
    case invite = "INVITE"
    case kick = "KICK"
    
    // server commands
    case messageOfTheDay = "MOTD"
    case version = "VERSION"
    case admin = "ADMIN"
    case connect = "CONNECT"
    case localUsers = "LUSERS"
    case time = "TIME"
    case statistics = "STATS"
    case help = "HELP"
    case information = "INFO"
    case mode = "MODE"

    // messages
    case privateMessage = "PRIVMSG"
    case notice = "NOTICE"

    // user queries
    case who = "WHO"
    case whois = "WHOIS"
    
    // operator commands
    case kill = "KILL"
    case rehash = "REHASH"
    case restart = "RESTART"
    case serverQuit = "SQUIT"
    
    // optional
    case away = "AWAY"
    case userHost = "USERHOST"
    case wallops = "WALLOPS"

    // numerics
    case replyWelcome = "001"
    case replyYourHost = "002"
    case replyCreated = "003"
    case replyMyInfo = "004"
    case replySupportedTokens = "005"
    case replyBounce = "010"
    case replyUserModes = "221"
    case replyLuserClient = "251"
    case replyLuserOperators = "252"
    case replyLuserUnknown = "253"
    case replyLuserChannels = "254"
    case replyLuserMe = "255"
    case replyAdminMe = "256"
    case replyAdminLocationLineOne = "257"
    case replyAdminLocationLineTwo = "258"
    case replyAdminEmail = "259"
    case replyTryAgain = "263"
    case replyLocalUsers = "265"
    case replyGlobalUsers = "266"
    case replyWhoIsCertificateFingerprint = "276"
    case replyNone = "300"
    case replyAway = "301"
    case replyUserHost = "302"
    case replyUnaway = "305"
    case replyNowAway = "306"
    case replyWhoIsRegisteredNickname = "307"
    case replyWhoIsUser = "311"
    case replyWhoIsServer = "312"
    case replyWhoWasUser = "314"
    case replyEndOfWho = "315"
    case replyWhoIsIdle = "317"
    case replyEndOfWhoIs = "318"
    case replyWhoIsChannels = "319"
    case replyWhoIsSpecial = "320"
    case replyListStart = "321"
    case replyList = "322"
    case replyListEnd = "323"
    case replyChannelModeIs = "324"
    case replyCreationTime = "329"
    case replyWhoIsAccount = "330"
    case replyNoTopic = "331"
    case replyTopic = "332"
    case replyTopicWhoTime = "333"
    case replyWhoIsActually = "338"
    case replyInviting = "341"
    case replyInviteList = "346"
    case replyEndOfInviteList = "347"
    case replyExceptList = "348"
    case replyEndOfExceptList = "349"
    case replyVersion = "351"
    case replyWhoReply = "352"
    case replyNames = "353"
    case replyEndOfNames = "366"
    case replyBanList = "367"
    case replyEndOfBanList = "368"
    case replyEndOfWhoWas = "369"
    case replyInfo = "371"
    case replyMessageOfTheDay = "372"
    case replyEndOfInfo = "374"
    case replyMessageOfTheDayStart = "375"
    case replyMessageOfTheDayEnd = "376"
    case replyWhoIsHost = "378"
    case replyWhoIsModes = "379"
    case replyYouAreOperator = "381"
    case replyRehashing = "382"
    case replyTime = "391"
    case errorUnknown = "400"
    case errorNoSuchNickname = "401"
    case errorNoSuchServer = "402"
    case errorNoSuchChannel = "403"
    case errorCannotSendToChannel = "404"
    case errorTooManyChannels = "405"
    case errorNoOrigin = "409"
    case errorInputTooLong = "417"
    case errorUnknownCommand = "421"
    case errorNoMessageOfTheDay = "422"
    case errorDisallowedNickname = "432"
    case errorNicknameInUse = "433"
    case errorUserNotInChannel = "441"
    case errorNotOnChannel = "442"
    case errorUserOnChannel = "443"
    case errorNotRegistered = "451"
    case errorNeedMoreParameters = "461"
    case errorAlreadyRegistered = "462"
    case errorPasswordMismatch = "464"
    case errorYouAreBanned = "465"
    case errorChannelIsFull = "471"
    case errorUnknownMode = "472"
    case errorInviteOnlyChannel = "473"
    case errorBannedFromChannel = "474"
    case errorBadChannelKey = "475"
    case errorBadChannelMask = "476"
    case errorNoPrivileges = "481"
    case errorChannelPrivilegesNeeded = "482"
    case errorCannotKillServer = "483"
    case errorCannotBecomeOperatorFromHost = "491"
    case errorUnknownModeFlag = "501"
    case errorUsersDoNotMatch = "502"
    case errorHelpNotFound = "524"
    case errorInvalidKey = "525"
    case replyStartTLS = "670"
    case replyWhoIsSecure = "671"
    case errorStartTLS = "691"
    case errorInvalidModeParameter = "696"
    case replyHelpStart = "704"
    case replyHelpText = "705"
    case replyHelpEnd = "706"
    case errorInsufficientPrivileges = "723"
    case replyLoggedIn = "900"
    case replyLoggedOut = "901"
    case errorNicknameLocked = "902"
    case replySASLSuccess = "903"
    case errorSASLFailure = "904"
    case errorSASLTooLong = "905"
    case errorSASLAborted = "906"
    case errorSASLAlready = "907"
    case replySASLMechanics = "908"
}