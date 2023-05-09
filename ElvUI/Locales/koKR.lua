-- Korean localization file for koKR.
local E = unpack(ElvUI)
local L = E.Libs.ACL:NewLocale('ElvUI', 'koKR')

L["UPDATE_REQUEST"] = "There seems to be an issue with your ElvUI installation. This may be a result of your Tukui Client being out of date. Please visit our download page and update your Tukui Client, then reinstall ElvUI."
L[" |cff00ff00bound to |r"] = " |cff00ff00키로 다음의 행동을 실행합니다 |r"
L["%s frame has a conflicting anchor point. Forcing the Buffs to be attached to the main unitframe."] = "%s 프레임에 버프를 본체 프레임에 강제로 연결하는 충돌 앵커가 있습니다."
L["%s is attempting to share his filters with you. Would you like to accept the request?"] = "%s 유저가 필터설정을 전송하려 합니다. 받으시겠습니까?"
L["%s is attempting to share the profile %s with you. Would you like to accept the request?"] = "%s 유저가 ElvUI 설정을 전송하려 합니다. 받으시겠습니까?"
L["%s: %s tried to call the protected function '%s'."] = "%s: %s 기능이 사용할 수 없는 %s 함수를 사용하려 합니다."
L["(Ctrl & Shift Click) Toggle CPU Profiling"] = "(CTRL & Shift 클릭) CPU 프로파일링 전환"
L["(Hold Shift) Memory Usage"] = "Shift: 메모리 사용량"
L["(Shift Click) Collect Garbage"] = "(Shift Click) 메모리를 정리/회수 합니다."
L["A raid marker feature is available by pressing Escape -> Keybinds. Scroll to the bottom -> ElvUI -> Raid Marker."] = "공격대 징표 기능은 [Esc > 단축키 설정] 에서 목록 아래쪽 [ElvUI > 공격대 징표(Raid Marker)] 설정합니다."
L["A setting you have changed will change an option for this character only. This setting that you have changed will be uneffected by changing user profiles. Changing this setting requires that you reload your User Interface."] = "이 설정은 캐릭터별로 따로 저장되므로\n프로필에 영향을 주지도, 받지도 않습니다.\n\n설정 적용을 위해 리로드 하시겠습니까?"
L["ABOVE_THREAT_FORMAT"] = "%s: %.0f%% [%.0f%% 정도 |cff%02x%02x%02x%s|r보다 많음]"
L["Accepting this will reset the UnitFrame settings for %s. Are you sure?"] = "수락하시면 %s의 설정이 초기화됩니다. 정말로 하시겠습니까?"
L["Accepting this will reset your Filter Priority lists for all auras on NamePlates. Are you sure?"] = "수락하시면 이름표에 적용된 모든 필터 목록이 초기화 됩니다. 정말로 하시겠습니까?"
L["Accepting this will reset your Filter Priority lists for all auras on UnitFrames. Are you sure?"] = "수락하시면 유닛프레임에 적용된 모든 필터 목록이 초기화 됩니다. 정말로 하시겠습니까?"
L["Active Output Audio Device"] = "오디오 장치 선택"
L["AddOn Memory:"] = "에드온 메모리"
L["Adjust the UI Scale to fit your screen."] = "화면의 UI 구성 크기를 설정합니다."
L["Affix"] = "부착"
L["AFK"] = "자리비움"
L["All keybindings cleared for |cff00ff00%s|r."] = "|cff00ff00%s|r 버튼에 설정된 모든 단축키 설정이 해제되었습니다."
L["Alliance: "] = "얼라이언스: "
L["Already Running.. Bailing Out!"] = "이미 실행중입니다. 잠시만 기다려 주세요."
L["Alternative Power"] = "특수상황 진행 바"
L["Ammo/Shard Counter"] = "탄약/영혼조각 수"
L["AP:"] = "전투력"
L["Archeology Progress Bar"] = "고고학 진척도 바"
L["Are you sure you want to apply this font to all ElvUI elements?"] = "정말로 이 글씨체를 ElvUI의 모든 구성요소에 적용하시겠습니까?"
L["Are you sure you want to disband the group?"] = "현재 그룹을 해산하시겠습니까?"
L["Are you sure you want to reset all the settings on this profile?"] = "현재 사용중인 프로필을 초기화 하시겠습니까?"
L["Are you sure you want to reset every mover back to it's default position?"] = "모든 프레임을 기본 위치로 초기화 하시겠습니까?"
L["Arena Frames"] = "투기장 프레임"
L["Arena"] = "투기장"
L["Aura Bars"] = "클래스타이머"
L["Auras Set"] = "오라(버프/디버프) 설정"
L["Auras"] = "오라 설정"
L["Auto Scale"] = "UI자동조절"
L["AVD: "] = "방어율: "
L["Avoidance Breakdown"] = "방어율 목록"
L["Azerite Bar"] = "아제라이트 바"
L["Bag Bar"] = "가방바"
L["Bags (Grow Down)"] = "가방 위치(아래로 성장)"
L["Bags (Grow Up)"] = "가방 위치(위로 성장)"
L["Bags"] = "가방"
L["Bandwidth"] = "대역폭"
L["Bank (Grow Down)"] = "은행 위치(아래로 성장)"
L["Bank (Grow Up)"] = "은행 위치(위로 성장)"
L["Bank"] = "은행"
L["Bar "] = "바 "
L["Bars"] = "바"
L["Battleground datatexts temporarily hidden, to show type /bgstats"] = "전장전용 정보문자를 일시적으로 숨겼습니다. 표시하려면 /bgstats 를 입력하세요"
L["Battleground datatexts will now show again if you are inside a battleground."] = "전장전용 정보문자를 다시 표시합니다."
L["BelowMinimapWidget"] = "진형 상태 바"
L["Binding"] = "주키/보조키"
L["BINDINGS_HELP"] = ("단축키 지정:*단축바|r,*매크로|r 또는 *마법책|r 에 마우스를 대고 단축키을 눌러 입력.*가방|r에 항목에도 적용됨. 저장을 눌러야만 적용됨."):gsub('*', E.InfoColor):gsub('%^', E.InfoColor2)
L["Binds Discarded"] = "단축키 지정을 취소 하였습니다."
L["Binds Saved"] = "단축키가 저장되었습니다."
L["Blizzard Widgets"] = "블리자드 위젯"
L["BNet Frame"] = "배틀넷 알림"
L["BoE"] = "착귀"
L["BoP"] = "획득 귀속"
L["Boss Button"] = "특수능력 버튼"
L["Boss Frames"] = "보스 프레임"
L["Boss"] = "보스(Boss)"
L["BossBannerWidget"] = "보스 베너 위쳇"
L["BoU"] = "사용 귀속"
L["Buffs"] = "강화효과"
L["Building(s) Report:"] = "건축 보고서"
L["Calendar"] = "달력"
L["Calling Quest(s) available."] = "퀘스트를 진행할 수 있습니다."
L["Can't buy anymore slots!"] = "더 이상 가방 칸을 늘릴 수 없습니다."
L["Can't Roll"] = "주사위를 굴릴 수 없습니다."
L["Character: "] = "캐릭터:"
L["Chat Set"] = "대화창 설정"
L["Chat"] = "채팅창"
L["Choose a theme layout you wish to use for your initial setup."] = "UI의 전체적인 분위기를 선택하세요."
L["Class Bar"] = "직업바"
L["Classic"] = "클래식"
L["Combat Indicator"] = "전투 표시기"
L["Combat"] = "전투"
L["Combat/Arena Time"] = "전투/투기장 시간"
L["Config Mode:"] = "표시할 프레임 계열:"
L["Confused.. Try Again!"] = "작업에 혼선이 있었습니다. 다시 시도해 주세요."
L["Continue"] = "계속"
L["Coords"] = "좌표"
L["copperabbrev"] = [[|TInterface\MoneyFrame\UI-MoneyIcons:0:0:1:0:64:16:33:48:1:16|t]]
L["Current Difficulties:"] = "현재 난이도:"
L["Current Level:"] = "현재 레벨"
L["CVars Set"] = "CVars 설정"
L["CVars"] = "게임 인터페이스 설정(CVars)"
L["Daily Reset"] = "매일 초기화"
L["Dark"] = "어두운 느낌"
L["Data From: %s"] = "%s 유저에게서 데이터 받는중..."
L["Dead"] = "죽음"
L["Debuffs"] = "약화효과"
L["Deficit:"] = "손해:"
L["Delete gray items?"] = "잡템을 삭제하시겠습니까?"
L["Deposit Reagents"] = _G.REAGENTBANK_DEPOSIT
L["Disable Warning"] = "비활성화 경고"
L["Disable"] = "비활성화"
L["Disabled"] = "장애가 있는"
L["Disband Group"] = "그룹 해산"
L["Discard"] = "작업 취소"
L["Discord"] = "디스코드"
L["DND"] = "다른 용무중"
L["Do you swear not to post in technical support about something not working without first disabling the addon/module combination first?"] = "두 애드온을 병행하여 생기는 문제를 스스로 감수하며 관련 질문글을 올리지 마세요."
L["Don't forget to backup your WTF folder, all your profiles and settings are in there."] = "WTF 폴더 백업을 잊지 마세요. 모든 프로필과 설정이 거기 있습니다."
L["Download"] = "다운로드"
L["DPS"] = "DPS"
L["Durability Frame"] = "내구도 프레임"
L["Earned:"] = "수입:"
L["Elite"] = "정예"
L["ElvUI has a dual spec feature which allows you to load different profiles based on your current spec on the fly. You can enable it in the profiles tab."] = "ElvUI에는 현재 특성에 따라 다른 프로필을 즉시 로드할 수 있는 이중 전문화 기능이 있습니다. 프로필 탭에서 활성화할 수 있습니다."
L["ElvUI Installation"] = "ElvUI 설치"
L["ElvUI is five or more revisions out of date. You can download the newest version from www.tukui.org. Get premium membership and have ElvUI automatically updated with the Tukui Client!"] = "현재 사용하는 ElvUI가 5버전 이상 뒤쳐진 버전입니다. http://www.tukui.org 에서 새 버전을 다운로드 받으세요. 프리미엄유저가 되어 Tukui Client 프로그램을 쓰면 자동으로 업데이트 해드립니다."
L["ElvUI is out of date. You can download the newest version from www.tukui.org. Get premium membership and have ElvUI automatically updated with the Tukui Client!"] = "ElvUI가 오래된 버전입니다. http://www.tukui.org 에서 새 버전을 다운로드 받으세요. 프리미엄유저가 되어 Tukui Client 프로그램을 쓰면 자동으로 업데이트 해드립니다."
L["ElvUI Plugin Installation"] = "ElvUI 플러그인  설치"
L["ElvUI Status"] = "ELVUI 상태창"
L["ElvUI Version:"] = "ElvUI 버전:"
L["Error resetting UnitFrame."] = "유닛프레임 초기화 오류"
L["EventToastWidget"] = "이벤트 알림"
L["Experience Bar"] = "경험치 바"
L["Experience"] = "경험치"
L["Filter download complete from %s, would you like to apply changes now?"] = "%s 유저에게서 필터 설정 다운로드가 완료되었습니다. 변경사항을 적용할까요?"
L["Finished"] = "마침"
L["Fishy Loot"] = "낚시 전리품"
L["Focus Aura Bars"] = "주시대상 오라 바"
L["Focus Castbar"] = "주시대상 시전바"
L["Focus Frame"] = "주시대상 프레임"
L["FocusTarget Frame"] = "주시대상의 대상 프레임"
L["Frame"] = "유닛프레임"
L["Friends List"] = "친구 목록"
L["From time to time you should compare your ElvUI version against the most recent version on our website or the Tukui client."] = "정기적으로 ElvUI 버전을 저희 웹 사이트 나 Tukui 클라이언트의 최신 버전과 비교해야합니다."
L["G"] = "길드"
L["Ghost"] = "유령"
L["GM Ticket Frame"] = "GM요청 번호표"
L["Gold"] = "골드"
L["goldabbrev"] =  [[|TInterface\MoneyFrame\UI-MoneyIcons:0:0:1:0:64:16:1:16:1:16|t]]
L["Grays"] = "회색"
L["Grid Size:"] = "격자 크기 :"
L["Heal Power"] = "치유력"
L["Healer"] = "힐러"
L["Hold Control + Right Click:"] = "Ctrl + 우클릭:"
L["Hold Shift + Drag:"] = "Shift + 드래그:"
L["Hold Shift + Right Click:"] = "Shift + 우클릭:"
L["Hold Shift:"] = "Shift:"
L["Home Latency:"] = "지연 시간:"
L["Home Protocol:"] = "기본 프로토콜"
L["Honor Bar"] = "명예바"
L["Honor Remaining:"] = "남은 명예"
L["Honor XP:"] = "명예 경험치"
L["Horde: "] = "호드: "
L["HP"] = "생명력"
L["HPS"] = "초당 힐"
L["I Swear"] = "알겠습니다."
L["I"] = "인던채팅"
L["Icons Only"] = "아이콘만 표시"
L["If you accidentally removed a default chat tab you can always re-run the chat part of the ElvUI installer."] = "실수로 기본 채팅 탭을 없앴더라도 ELVUI 인스톨러(설치) 채팅 단계에서 언제라도 다시 실행 가능합니다."
L["If you are experiencing issues with ElvUI try disabling all your addons except ElvUI first."] = "ELVUI를 쓰면서 문제를 경험중이시라면 우선은 ELVUI를 제외한 다른 애드온을 다 비활성화 해보십시오."
L["If you have an icon or aurabar that you don't want to display simply hold down shift and right click the icon for it to disapear."] ="표시하고 싶지 않은 아이콘이나 오라바가 있는 경우 Shift + 마우스 오른쪽 버튼으로 클릭하면 사라집니다."
L["IL"] = "인스장"
L["Importance: |cFF33FF33Low|r"] = "중요도 : |cFF33FF33낮음|r"
L["Importance: |cffD3CF00Medium|r"] = "중요도: |cffD3CF00보통|r"
L["Importance: |cffFF3333High|r"] = "중요도: |cffFF3333높음|r"
L["In Progress"] = "진행 중"
L["INCOMPATIBLE_ADDON"] = "%s의 기능이 ElvUI의 %s 모듈과 충돌 됩니다. \n사용할 기능 또는 모듈을 선택하세요."
L["Installation Complete"] = "설치 완료"
L["Interrupted %s's |cff71d5ff|Hspell:%d:0|h[%s]|h|r!"] = "%s의 |cff71d5ff|Hspell:%d:0|h[%s]|h|r 차단함!"
L["Invalid Target"] = "잘못된 대상"
L["is looking for members"] = "구성원 찾는 중"
L["It appears one of your AddOns have disabled the AddOn Blizzard_CompactRaidFrames. This can cause errors and other issues. The AddOn will now be re-enabled."] = "현재 설치된 애드온 중 하나가 정상 로드되지 않았습니다. 에러가 날 확률이 높아 리로드합니다."
L["Item level: %.2f"] = "아이템 레벨: %.2f"
L["Item Level:"] = "아이템 레벨"
L["joined a group"] = "그룹에 참여"
L["Key"] = "단축키"
L["KEY_ALT"] = "A"
L["KEY_CTRL"] = "C"
L["KEY_DELETE"] = "Del"
L["KEY_HOME"] = "Hm"
L["KEY_INSERT"] = "Ins"
L["KEY_MOUSEBUTTON"] = "M"
L["KEY_MOUSEWHEELDOWN"] = "W▼"
L["KEY_MOUSEWHEELUP"] = "W▲"
L["KEY_NDIVIDE"] = "N/"
L["KEY_NEQUALS"] = "N="
L["KEY_NMINUS"] = "N-"
L["KEY_NMULTIPLY"] = "N*"
L["KEY_NPLUS"] = "N+"
L["KEY_NUMPAD"] = "N"
L["KEY_PAGEDOWN"] = "P▼"
L["KEY_PAGEUP"] = "P▲"
L["KEY_SHIFT"] = "S"
L["KEY_SPACE"] = "Spc"
L["Layout Set"] = "레이아웃 설정"
L["Layout"] = "레이아웃"
L["Left Chat"] = "왼쪽 패널"
L["Left Click:"] = "왼 클릭 :"
L["Level %d"] = "레벨 %d"
L["Level"] = "레벨"
L["List of installations in queue:"] = "설치 대기열 목록"
L["Loadouts"] = "로드아웃"
L["Location"] = "위치"
L["Lock"] = "잠금"
L["LOGIN_MSG"] = ("*ElvUI|r 버전 *%.2f|r이 설치 되었습니다.\n메뉴 호출은*/ec|r.기술 지원은 https://www.tukui.org \n또는,*Discord :|r https://discord.gg/xFWcfgE"):gsub('*', E.InfoColor)
L["LOGIN_MSG_HELP"] = ("*ElvUI|r 명령어 목록은 */ehelp|r를 입력하면 됩니다."):gsub('*', E.InfoColor)
L["LOGIN_PTR"] = ("|cffff3333현재 *ElvUI|r의 PTR 버전을 실행하고 있지 않아 문제가 발생할 수 있습니다.|r ^다음 링크에서 PTR 버전을 다운로드하십시오.|r %s"):gsub('*', E.InfoColor):gsub('%^', E.InfoColor2)
L["Loot / Alert Frames"] = "획득/알림 창"
L["Loot Frame"] = "전리품 프레임"
L["Lord! It's a miracle! The download up and vanished like a fart in the wind! Try Again!"] = "데이터를 받는 중 혼선이 생겼습니다. 다시 시도해주세요."
L["Loss Control Icon"] = "제어손실 표시"
L["lvl"] = "레벨"
L["MA Frames"] = "지원공격 전담 프레임"
L["Max Level"] = "최고 래벨"
L["Micro Bar"] = "메뉴모음 바"
L["Minimap Cluster"] = "미니맵 클러스터"
L["Minimap"] = "미니맵"
L["MirrorTimer"] = "미러 타이머"
L["Mission(s) Report:"] = "임무 보고서"
L["Mitigation By Level: "] = "레벨별 데미지 경감률"
L["Mobile"] = "모바일"
L["Mov. Speed"] = "이동 속도"
L["MT Frames"] = "방어전담 프레임"
L["Mythic+ Best Run:"] = "신화 최고 기록:" -- 어둠땅 메뉴
L["Mythic+ Score:"] = "신화 점수:" -- 어둠땅 메뉴
L["Naval Mission(s) Report:"] = "해상 임무 보고서"
L["Need help? Join our Discord: https://discord.gg/xFWcfgE"] = "도움이 필요할땐 우리 디스코드에 서버에 참가해보세요: https://discord.gg/xFWcfgE"
L["New Profile will create a fresh profile for this character."] = "'새로운 프로필'은 이 캐릭터에 대한 프로필을 만듭니다."
L["New Profile"] = "새로운 프로필"
L["No bindings set."] = "설정한 단축키가 없습니다."
L["No gray items to delete."] = "잡동사니가 없습니다."
L["No Guild"] = "길드 없음"
L["No Loot"] = "전리품 없음"
L["None"] = "없음"
L["Nudge"] = "미세조정"
L["O"] = "관리자"
L["Objective Frame"] = "퀘스트 프레임"
L["Offline"] = "오프라인"
L["Oh lord, you have got ElvUI and Tukui both enabled at the same time. Select an addon to disable."] = "ElvUI 와 TukUI 를 동시에 사용하려 하고 있습니다. 하나만 선택해 주세요."
L["One or more of the changes you have made require a ReloadUI."] = "변경 사항을 적용하려면 애드온을 리로드 해야합니다."
L["One or more of the changes you have made will effect all characters using this addon. You will have to reload the user interface to see the changes you have made."] = "이 설정은 모든 캐릭터에게 동일하게 적용됩니다.\n\n설정 적용을 위해 리로드 하시겠습니까?"
L["Output Audio Device"] = "오디오 출력 장치"
L["P"] = "파티"
L["Paragon"] = "모범"
L["Party Frames"] = "파티 프레임"
L["Pending"] = "미결"
L["Pet Aura Bars"] = "소환수 오라바"
L["Pet Bar"] = "소환수 바"
L["Pet Castbar"] = "소환수 시전바"
L["Pet Experience Bar"] = "소환수 경험치 바"
L["Pet Experience"] = "소환수 경험치"
L["Pet Frame"] = "소환수 프레임"
L["PetTarget Frame"] = "소환수 대상 프레임"
L["PL"] = "파티장"
L["Player Aura Bars"] = "플레이어 오라바"
L["Player Buffs"] = "플레이어 버프"
L["Player Castbar"] = "플레이어 시전바"
L["Player Debuffs"] = "플레이어 디버프"
L["Player Frame"] = "플레이어 프레임"
L["Player NamePlate"] = "플레이어 이룜표"
L["Please click the button below so you can setup variables and ReloadUI."] = "아래 버튼을 누르면 설치를 마무리하고 UI를 재시작합니다."
L["Please click the button below to setup your CVars."] = "ElvUI의 게임 인터페이스 설정을 적용하려면 아래 버튼을 클릭하세요."
L["Please click the button below to setup your Profile Settings."] = "프로필 설정 하려면 아래 버튼을 누르세요."
L["Please press the continue button to go onto the next step."] = "|cff2eb7e4[계속]|r 버튼으로 설치를 진행하세요."
L["PowerBarWidget"] = "자원바 위젯"
L["Profile download complete from %s, but the profile %s already exists. Change the name or else it will overwrite the existing profile."] = "%s 유저에게서 ElvUI 설정 다운로드가 완료되었습니다. 하지만 건네받은 프로필 이름이 이미 존재합니다. 프로필이름을 바꾸지 않으면 기존의 것에 덮어씌웁니다."
L["Profile download complete from %s, would you like to load the profile %s now?"] = "%s 유저에게서 ElvUI 설정 다운로드가 완료되었습니다. 건네받은 설정을 지금 불러올까요?"
L["Profile request sent. Waiting for response from player."] = "상대에게서 전송여부를 확인받고 있습니다."
L["Profile Settings Setup"] = "프로필 배치 설정"
L["Profit:"] = "이익:"
L["Purchase Bags"] = "가방 슬롯 구입"
L["Purchase"] = "구입"
L["Quest Log XP:"] = "퀘스트 기록 경험치"
L["Quest Log"] = "퀘스트 일지"
L["Quest Objective Frame"] = "퀘스트 목표 프레임"
L["Quest Timer Frame"] = "퀘스트 타임 프레임"
L["R"] = "공대"
--L["Raid %d Frames"] = true
L["Raid Menu"] = "공대 매뉴"
L["Raid Pet Frames"] = "레이드 소환수 프레임"
L["Rare Elite"] = "정예 희귀"
L["Rare"] = "정예"
L["Reagent Bank"] = _G.REAGENT_BANK
L["Remaining:"] = "다음 레벨까지: "
L["Remove Bar %d Action Page"] = "Blizzard %d번 행동단축바 숨기기"
L["Reposition Window"] = "창 위치 재설정"
L["Reputation Bar"] = "평판 바"
L["Request was denied by user."] = "상대방이 전송을 거절했습니다."
L["Reset Character Data: Hold Shift + Right Click"] = "캐릭터 자료 초기화: 쉬프트 + 우클릭"
L["Reset Position"] = "위치 초기화"
L["Reset Session Data: Hold Ctrl + Right Click"] = "정보 데이터 재설정 : Ctrl + 오른쪽 클릭"
L["Rested:"] = "휴식 경험치:"
L["Right Chat"] = "오른쪽 패널"
L["Right Click to Open Menu"] = "오른쪽 클릭 클릭 메뉴를 열림"
L["RL"] = "공대장"
L["RW"] = "경보"
L["Save"] = "저장"
L["Saved Dungeon(s)"] = "귀속된 던전"
L["Saved Raid(s)"] = "귀속된 던전"
L["says"] = "일반"
L["Select the type of aura system you want to use with ElvUI's unitframes. Set to Aura Bars to use both aura bars and icons, set to Icons Only to only see icons."] = "ElvUI의 유닛 프레임과 함께 사용할 오라(버프/디버프) 유형을 선택하십시오. '클래스타이머'와 '아이콘'을 모두 사용하려면 '클래스타이머'로 설정하고' '아이콘'만 보려면 '아이콘만 표시'를 선택합니다.!!"
L["Select Volume Stream"] = "볼륨 전환 선택"
L["Server: "] = "서버:"
L["Session:"] = "현재 접속:"
L["Setup Chat"] = "대화창 설치"
L["Setup CVars"] = "인터페이스 설정 적용"
L["Shared Profile will select the default profile."] = "'공유 프로필'은 기본(기본값) 프로필을 선택합니다."
L["Shared Profile"] = "프로필 공유"
L["Shift + Left Click to Toggle Bag"] = "Shift + 왼쪽 클릭 가방 열기"
L["Show/Hide Reagents"] = "재료 은행보유 표시"
L["Shows a frame with needed info for support."] = "ElvUI의 AddOn 상세정보와 Plugins 정보창을 표시합니다."
L["silverabbrev"] = [[|TInterface\MoneyFrame\UI-MoneyIcons:0:0:1:0:64:16:17:32:1:16|t]]
L["Sort Bags"] = "가방 정리"
L["SP"] = "주문력"
L["Spec"] = "전문화"
L["Spell Haste"] = "가속도"
L["Spell Hit"] = "주문 적중"
L["Spell Power"] = "주문력"
L["Spent:"] = "지출:"
L["Stack Items In Bags"] = "가방에 아이템 겹치기"
L["Stack Items In Bank"] = "은행에 아이템 겹치기"
L["Stack Items To Bags"] = "가방에 물품 겹치기"
L["Stack Items To Bank"] = "은행에 물품 겹치기"
L["Stance Bar"] = "태세 바"
L["Steps"] = "단계"
L["Sticky Frames"] = "자석"
L["System"] = "시스템"
L["Talent/Loot Specialization"] = "전문화/전리품 획득 전문화 변경"
L["Target Aura Bars"] = "대상 오라바"
L["Target Castbar"] = "대상 시전바"
L["Target Frame"] = "대상 프레임"
L["Target Mitigation"] = "대상 방어"
L["Targeted By:"] = "선택됨:"
L["TargetTarget Frame"] = "대상의대상 프레임"
L["TargetTargetTarget Frame"] = "대상의대상의대상 프레임"
L["Temporary Move"] = "임시 이동"
L["The chat windows function the same as Blizzard standard chat windows, you can right click the tabs and drag them around, rename, etc. Please click the button below to setup your chat windows."] = "보편적인 설정을 적용할 뿐이므로, 마음대로 채널표시나 색상을 변경할 수 있습니다.\n아래 버튼을 클릭하면 채팅창 설정을 적용합니다."
L["The in-game configuration menu can be accessed by typing the /ec command. Press the button below if you wish to skip the installation process."] = "/ec 명령을 입력하여 옵션창을 호출할 수 있습니다.\n설치 과정을 건너 뛰려면 아래 버튼을 누르십시오."
L["The profile you tried to import already exists. Choose a new name or accept to overwrite the existing profile."] = "불러오려는 프로필이 이미 존재합니다. 새로운 이름을 지정하시거나 기존 프로필에 덮어쓸지를 선택하십시오."
L["The spell '%s' has been added to the '%s' unitframe aura filter."] = "%s 주문이 차단 목록에 등록되었습니다."
L["Theme Set"] = "테마 적용"
L["Theme Setup"] = "테마 설정"
L["This install process will help you learn some of the features in ElvUI has to offer and also prepare your user interface for usage."] = "이 설치과정을 통해 ElvUI를 좀 더 자신에게 맞게 설정하고\n몇가지 기능에 대해 알 수 있습니다."
L["This part of the installation process sets up your chat windows names, positions and colors."] = "채팅창 설정을 변경합니다. 간단한 채널설정, 색상설정 등이 포함되어 있습니다.\n자신만의 채널 설정, 색상 등을 유지하고 싶으면 설치하지 마세요."
L["This part of the installation process sets up your World of Warcraft default options it is recommended you should do this step for everything to behave properly."] = "WoW의 기본 인터페이스 설정을 ElvUI에 적합하게 변경합니다. 애드온 사용에 있어 유용하니 적용할 것을 추천합니다."
L["This setting caused a conflicting anchor point, where '%s' would be attached to itself. Please check your anchor points. Setting '%s' to be attached to '%s'."] = "이 설정으로 인해 앵커 위치가 충돌하여 '%s'가 고정되었습니다. 앵커 위치를 확인하십시오. '%s'가 '%s'에 연결되도록 설정합니다."
L["This will change the layout of your unitframes and actionbars."] = "역할에 따라서 유닛프레임과 행동단축바의 레이아웃이 알맞게 바뀝니다."
L["Threat Bar"] = "어그로 바"
L["Time Alert Frame"] = "시간 경고 프레임"
L["To list all available ElvUI commands, type in chat /ehelp"] = "사용가능한 ELVUI 명령을 모두 보려면 /ehelp 를 입력하세요"
L["To quickly move around certain elements of the UI, type /emove"] = "UI의 특정 요소를 빠르게 이동하려면 '/emove'를 입력합니다."
L["To setup chat colors, chat channels and chat font size, right-click the chat tab name."] = "채팅탭 우클릭으로 대화 색상,채널 및 대화 글꼴 크기등 설정을 변경할 수 있습니다."
L["Toggle Anchors"] = "프레임 이동 모드"
L["Toggle Bags"] = "가방슬롯 보기"
L["Toggle Chat Frame"] = "패널 표시 전환"
L["Toggle Configuration"] = "ElvUI 설정창 열기"
L["Toggle Tutorials"] = "튜토리얼 학습"
L["Toggle Volume Stream"] = "볼륨 조정 열기"
L["Tooltip"] = "툴팁"
L["TopCenterWidget"] = "상단 중앙 구성 요소"
L["Torghast Choice Toggle"] = "토르가스트 선택"
L["Total CPU:"] = "전체 CPU 사용량:"
L["Total: "] = "합계:"
L["Totem Bar"] = "토템바"
L["Totem Tracker"] = "토템 추적"
L["Trigger"] = "묶음을 펼치고 각 주문에 지정하세요."
L["UI Scale"] = "UI 크기"
L["Unhittable:"] = "100% 방어행동까지"
L["Vehicle Seat Frame"] = "차량 좌석 프레임"
L["VehicleLeaveButton"] = "탈것 내기리 버튼"
L["Vendor / Delete Grays"] = "잡템 자동판매/삭제"
L["Vendor Grays"] = "잡동사니 자동판매"
L["Vendored gray items for: %s"] = "모든 잡동사니를 팔았습니다: %s"
L["Vendoring Grays"] = "잡템 팔기"
L["Voice Overlay"] = "음성 오버레이"
L["Volume Streams"] = "볼륨 조정"
L["Volume"] = "볼륨"
L["Welcome to ElvUI version %.2f!"] = "ElvUI 버전 %.2f에 오신 것을 환영합니다!"
L["whispers"] = "귓말"
L["World Latency:"] = "월드 지연시간"
L["World Protocol:"] = "월드 프로토콜"
L["WoW Token:"] = "와우 토큰"
L["XP:"] = "경험치:"
L["yells"] = "외침"
L["You are now finished with the installation process. If you are in need of technical support please join our Discord."] = "설치가 완료되었습니다. 기술 지원이 필요하시면 당사의 Discord에 가입/이용 하세요."
L["You are using CPU Profiling. This causes decreased performance. Do you want to disable it or continue?"] = "CPU 사용량을 추적하고 있습니다. 이로 인해 성능이 저하됩니다. 사용 안 함으로 설정하시겠습니까? 아니면 계속하시겠습니까?"
L["You can access the copy chat and chat menu functions by left/right clicking on the icon in the top right corner of the chat panel."] = "대화 패널의 오른쪽 상단에 있는 아이콘을 왼쪽/오른쪽으로 클릭하면 대화 복사 및 대화 메뉴 기능에 이용할수 있습니다."
L["You can access the microbar by using middle mouse button on the minimap. You can also enable the MicroBar in the actionbar settings."] = "미니맵에서 마우스 가운데 버튼을 사용하여 미니맵버튼바에 접근할 수 있습니다. 또한 작업 표시줄 설정에서 미니맵버튼바를 활성화할 수도 있습니다."
L["You can always change fonts and colors of any element of ElvUI from the in-game configuration."] = "ElvUI에서 표시하는 폰트나 색상은 설정에서 언제든지 바꿀 수 있습니다."
L["You can enter the keybind mode by typing /kb"] = "/kb 를 입력하면 단축키 설정 모드로 들어갈 수 있습니다."
L["You can now choose what layout you wish to use based on your combat role."] = "게임 안에서 주로 플레이하는 전문화 역할을 선택하세요."
L["You can quickly change your displayed DataTexts by mousing over them while holding ALT."] = "ALT를 누른 상태에서 마우스를 올려 표시된 데이터문자를 빠르게 변경할 수 있습니다."
L["You can see someones average item level inside the tooltip by holding shift and mousing over them."] = "Shift를 누른 상태에서 마우스를 가져가면 툴팁 내에서 누군가의 평균 아이템 레벨을 볼 수 있습니다."
L["You don't have enough money to repair."] = "수리 비용이 부족합니다."
L["You don't have permission to mark targets."] = "레이드 아이콘을 지정할 권한이 없습니다."
L["You have imported settings which may require a UI reload to take effect. Reload now?"] = "적용을 위해 UI 다시불러오기가 필요할 수 있는 설정을 가져왔습니다. 지금 UI를 재시작하시겠습니까?"
L["You must be at a vendor."] = "상인을 만나야 가능합니다."
L["You must purchase a bank slot first!"] = "우선 은행가방 칸을 구입해야됩니다!"
L["Your items have been repaired for: "] = "자동으로 수리하고 비용을 지불했습니다: "
L["Your items have been repaired using guild bank funds for: "] = "길드자금으로 수리하고 비용을 지불했습니다: "
L["Your profile was successfully recieved by the player."] = "상대에게 데이터를 성공적으로 전송했습니다."
L["Zone Ability"] = "지역 특수 능력"
L["|cFFE30000Lua error recieved. You can view the error message when you exit combat."] = "Lua 에러가 발생하였습니다. 전투가 끝난 후에 내역을 표시하겠습니다."
L["|cffFFFFFFControl + Left Click:|r Change Loadout"] = "Ctrl + 좌 클릭:|r 로드아웃 변경"
L["|cffFFFFFFLeft Click:|r Change Talent Specialization"] = "|cffFFFFFF좌 클릭:|r 특성 교체"
L["|cFFffffffLeft Click:|r Select Volume Stream"] = "|cFFffffff 좌 클릭:|r 오디오 연결 선택"
L["|cFFffffffMiddle Click:|r Toggle Mute Master Stream"] = "|cFFffffff가운데 버튼:|r 메인 오디오 연결 음소거 전환"
L["|cffFFFFFFRight Click:|r Change Loot Specialization"] = "|cffFFFFFF우 클릭:|r 전리품 획득 변경"
L["|cFFffffffRight Click:|r Toggle Volume Stream"] = "|cFFffffff우 클릭:|r 오디오 연결 전환"
L["|cFFffffffShift + Left Click:|r Open System Audio Panel"] = "|cFFffffffShift + 좌 클릭:|r 시스템 오디오 패널 열기"
L["|cffFFFFFFShift + Left Click:|r Show Talent Specialization UI"] = "|cffFFFFFFShift + 클릭:|r 특성 전문화창 보기"
L["|cFFffffffShift + Right Click:|r Select Output Audio Device"] = "|cFFffffffShift + 우 클릭:|r 출력 오디오 장치 선택"

----------------------------------
L["DESC_MOVERCONFIG"] = [=[프레임을 드래그로 원하는 위치로 이동시키세요.\n[잠금] 버튼을 누르면 이동모드가 종료됩니다.

선택사항:
  좌클릭 - 위치조정 프레임 호출.
  우클릭 - 상세 매뉴 호출.
  Shift + 우클릭 - 조정자를 일시적으로 숨깁니다.
  Ctrl + 우클릭 - 조정자의 위치를 기본값으로 초기화합니다.
]=]

L["EHELP_COMMANDS"] = ([=[Here is a list of all important *ElvUI|r commands:
 */ec|r or */elvui|r  -  Toggle the *Options|r.
 */kb|r  -  Toggle the keybind mode.
 */emove|r  -  Toggle anchors to reposition various elements.
 */ereset|r  -  Reset all frames to their original positions.
 */bgstats|r  -  Toggle Battleground stats on your DataTexts.
 */estatus|r  -  Important informations for support questions.
 */egrid|r ^64|r or ^128|r or ^256|r  -  Toggle a pixel grid.
 */edebug|r ^on|r or ^off|r  -  Disable all AddOns except ElvUI.
  NOTE: */edebug|r ^off|r will re-enable the addons disabled from
  using */edebug|r ^on|r within that session.
]=]):gsub('*', E.InfoColor):gsub('%^', E.InfoColor2)
