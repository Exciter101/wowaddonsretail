
local L = LibStub("AceLocale-3.0"):NewLocale("BagSync", "deDE")
if not L then return end

--special thanks to Dlarge, GrimPala from wowinterface.com

L.Yes = "Ja"
L.No = "Nein"
L.TooltipCrossRealmTag = "XR"
L.TooltipBattleNetTag = "BN"
L.TooltipBag = "Taschen:"
L.TooltipBank = "Bank:"
L.TooltipEquip = "Angelegt:"
L.TooltipGuild = "Gilde:"
L.TooltipMail = "Post:"
L.TooltipVoid = "Leerenlager:"
L.TooltipReagent = "Materiallager:"
L.TooltipAuction = "AH:"
L.TooltipTotal = "Gesamt:"
L.TooltipItemID = "[ItemID]:"
L.TooltipDebug = "[Debug]:"
L.TooltipCurrencyID = "[WährungsID]:"
L.TooltipFakeID = "[FakeID]:"
L.TooltipDelimiter = ", "
L.TooltipRealmKey = "RealmKey:"
L.Search = "Suche"
L.AdvSearchBtn = "Suche/Aktualisierung"
L.Reset = "Zurücksetzen"
L.Refresh = "Aktualisierung"
L.AdvancedSearch = "Erweiterte Suche"
L.AdvancedSearchInformation = "* Benutze BagSync |cffff7d0a[XR]|r und |cff3587ff[BNet]|r Einstellungen."
L.AdvancedLocationInformation = "* Wenn Du keine auswählst, wird standardmäßig ALLE ausgewählt."
L.Units = "Einheiten:"
L.Locations = "Standort:"
L.Profiles = "Profile"
L.Professions = "Berufe"
L.Currency = "Währung"
L.Blacklist = "Blacklist"
L.Recipes = "Rezepte"
L.Gold = "Gold"
L.Close = "Schließen"
L.FixDB = "FixDB"
L.Config = "Einstellungen"
L.DeleteWarning = "Wähle ein Profil zum löschen aus. INFO: Dies ist nicht umkehrbar!"
L.Delete = "Löschen"
L.Confirm = "Bestätigen"
L.FixDBComplete = "Die Funktion FixDB wurde ausgeführt! Die Datenbank wurde optimiert!"
L.ResetDBInfo = "BaySync:\Bist Du sicher, dass Du die Datenbank zurücksetzen möchtest?\in|cFFDF2B2B HINWEIS: Dies kann nicht rückgängig gemacht werden!|r"
L.ON = "An"
L.OFF = "Aus"
L.LeftClickSearch = "|cffddff00Links Klick|r |cff00ff00= Suchen|r"
L.RightClickBagSyncMenu = "|cffddff00Rechts Klick|r |cff00ff00= BagSync Menu|r"
L.ProfessionInformation = "|cffddff00Links Klick|r |cff00ff00a Beruf zum Anzeigen von Rezepten.|r"
L.ClickViewProfession = "Klicke hier, um den Beruf anzuzeigen: "
L.ClickHere = "Klicke hier"
L.ErrorUserNotFound = "BagSync: Fehler, Benutzer nicht gefunden!"
L.EnterItemID = "Trage bitte eine ItemID ein. (Benutze wowhead.com)"
L.AddGuild = "Gilde einfügen"
L.AddItemID = "ItemID Einfügen"
L.RemoveItemID = "Entferne ItemID"
L.ItemIDNotFound = "[%s] ItemID nicht gefunden. Versuche es erneut!"
L.ItemIDNotValid = "[%s] ItemID ungültige ItemID oder der Server hat nicht geantwortet. Versuche es erneut!"
L.ItemIDRemoved = "[%s] ItemID entfernt"
L.ItemIDAdded = "[%s] ItemID hinzugefügt"
L.ItemIDExist = "[%s] ItemID bereits in Blacklist Datenbank."
L.GuildExist = "Gilde [%s] bereits in Blacklist Datenbank."
L.GuildAdded = "Gilde [%s] hinzugefügt"
L.GuildRemoved = "Guilde [%s] entfernt"
L.BlackListRemove = "[%s] von der Blacklist entfernen?"
L.BlackListErrorRemove = "Fehler beim Löschen von der Blacklist."
L.ProfilesRemove = "Entferne [%s][|cFF99CC33%s|r] Profil von BagSync?"
L.ProfilesErrorRemove = "Fehler beim Löschen aus BagSync."
L.ProfileBeenRemoved = "[%s][|cFF99CC33%s|r] Profil entfert von BagSync!"
L.ProfessionsFailedRequest = "[%s] Serveranforderung fehlgeschlagen."
L.ProfessionHasRecipes = "Klicke mit der linken Maustaste, um Rezepte anzuzeigen."
L.ProfessionHasNoRecipes = "Hat keine Rezepte zum Anzeigen."
L.KeybindBlacklist = "Zeige Schwarze Liste Fenster"
L.KeybindCurrency = "Zeige Währungsfenster"
L.KeybindGold = "Zeige Gold Tooltip"
L.KeybindProfessions = "Zeige Berufefenster"
L.KeybindProfiles = "Zeige Profilfenster"
L.KeybindSearch = "Zeige Suchfenster"
L.ObsoleteWarning = "\n\nNotiz: Veraltete Artikel werden weiterhin als fehlend angezeigt. Um dieses Problem zu beheben, scanne Deine Charaktere erneut, um veraltete Gegenstände zu entfernen.\n(Taschen, Bank, Reagenzien, Leerenlager, etc...)"
L.DatabaseReset = "Aufgrund von Änderungen in der Datenbank. Deine BagSync Datenbank wurde zurückgesetzt."
L.UnitDBAuctionReset = "Die Auktionsdaten wurden für alle Charaktere zurückgesetzt."
L.ScanGuildBankStart = "Abfrage des Servers für Informationen zur Gildenbank, bitte warten....."
L.ScanGuildBankDone = "Gildenbank Scan abgeschlossen!"
L.ScanGuildBankError = "Warnung: Das Scannen der Gildenbank ist unvollständig."
L.ScanGuildBankScanInfo = "Scanne Gildentab (%s/%s)."
L.DefaultColors = "Standard Farben"
-- ----THESE ARE FOR SLASH COMMANDS OPERATORS
L.SlashItemName = "[gegenstandsname]"
L.SlashSearch = "suche"
L.SlashGold = "gold"
L.SlashMoney = "geld"
L.SlashConfig = "einstellungen"
L.SlashCurrency = "währung"
L.SlashFixDB = "fixdb"
L.SlashProfiles = "profile"
L.SlashProfessions = "berufe"
L.SlashBlacklist = "blacklist"
L.SlashResetDB = "resetdb"
------------------------
-- ----THESE USE THE SLASH OPERATOR COMMANDS FOUND ABOVE
L.HelpCurrencyWindow = "/bgs currency - Öffnet das Währungsfenster"
L.HelpResetDB = "/bgs resetdb - Setzt die gesamte BagSync Datenbank zurück"
L.HelpSearchItemName = "/bgs [itemname] - Nach einem Item suchen"
L.HelpSearchWindow = "/bgs search - Öffnet das Suchfenster"
L.HelpGoldTooltip = "/bgs gold (or /bgs money) - Zeigt einen Tooltip mit dem Gold eines jeden Charakters"
L.HelpProfilesWindow = "/bgs profiles - Öffnet das Profilfenster"
L.HelpFixDB = "/bgs fixdb - Führt eine Reparatur der Datenbank (FixDB) aus"
L.HelpConfigWindow = "/bgs config - Öffnet die Einstellungen für BagSync"
L.HelpProfessionsWindow = "/bgs professions - Öffnet das Berufefenster"
L.HelpBlacklistWindow = "/bgs blacklist - Öffnet das Schwarze Liste Fenster"
------------------------
L.EnableBagSyncTooltip = "Aktiviere BagSync Tooltips"
L.EnableExtTooltip = "Zeige Artikelzähldaten in einer externen QuickInfo an"
L.EnableLoginVersionInfo = "BagSync Versionsinfo bei der Anmeldung anzeigen"
L.FocusSearchEditBox = "Suchfeld beim Öffnen des Suchfensters fokussieren"
L.DisplayTotal = "Anzeige des [Gesamt] Betrags."
L.DisplayGuildGoldInGoldTooltip = "Zeige [Gilde] Goldsummen im Gold Tooltip an"
L.DisplayGuildBank = "Gildenbankgegenstände anzeigen. |cFF99CC33(Aktiviert das Scannen von Gildenbanken)|r"
L.DisplayMailbox = "Postfachgegenstände anzeigen"
L.DisplayAuctionHouse = "Auktionshausgegenstände anzeigen"
L.DisplayMinimap = "BagSync Minikartensymbol anzeigen"
L.DisplayFaction = "Gegenstände für beide Fraktionen anzeigen (Allianz / Horde)"
L.DisplayClassColor = "Klassenfarben für Charaktere anzeigen"
L.DisplayTooltipOnlySearch = "BagSync Tooltip |cFF99CC33(NUR)|r im Suchfenster anzeigen"
L.DisplayLineSeperator = "Aktiviere eine leere Linie als Seperator über der BagSync Tooltipanzeige"
L.DisplayCrossRealm = "Aktiviere Gegenstände für Cross-Realm Charaktere.  |cffff7d0a[XR]|r"
L.DisplayBNET = "Aktiviere Battle.net Account Charaktere. |cff3587ff[BNet]|r |cFFDF2B2B(Nicht empfohlen!)|r"
L.DisplayItemID = "ItemID im Tooltip anzeigen"
L.DisplaySourceDebugInfo = "Zeigt hilfreiche [Debug] Informationen im Tooltip an"
L.DisplayTooltipTags = "Tags"
L.DisplayTooltipStorage = "Lagerung"
L.DisplayTooltipExtra = "Extra"
L.DisplayTooltipAccountWide = "Accountweit"
L.DisplayGreenCheck = "Zeige %s neben dem aktuellen Charakternamen an"
L.DisplayRealmIDTags = "Zeige |cffff7d0a[XR]|r- und |cff3587ff[BNet]|r-Realm-IDs an"
L.DisplayRealmNames = "Realname anzeigen."
L.DisplayRealmAstrick = "Zeige [*] anstelle von Realmnamen für |cffff7d0a[XR]|r und |cff3587ff[BNet]|r an"
L.DisplayShortRealmName = "Kurze Realmnamen für |cffff7d0a[XR]|r und |cff3587ff[BNet]|r anzeigen"
L.DisplayFactionIcons = "Fraktionssymbole im Tooltip anzeigen"
L.DisplayGuildCurrentCharacter = "Zeige [Gilden] Gegenstände nur für den aktuell eingeloggten Charakter"
L.DisplayGuildBankScanAlert = "Zeigt das Scan Warnfenster der Gildenbank an"
L.DisplayAccurateBattlePets = "Genaue Kampfhaustiere in der Gildenbank und Mailbox aktivieren. |cFFDF2B2B(Kann zu Verzögerungen führen)|r |cff3587ff[Siehe BagSync FAQ]|r"
L.DisplayShowUniqueItemsTotals = "Wenn Du diese Option aktivierst, können einzigartige Gegenstände zur Gesamtzahl der Gegenstände hinzugefügt werden, unabhängig von den Gegenstandsstatistiken. |cFF99CC33(Empfohlen)|r."
L.DisplayShowUniqueItemsTotals_2 = [[
Bestimmte Gegenstände wie |cffff7d0a[Legendäre]|r können den gleichen Namen haben, aber unterschiedliche Werte haben. Da diese Artikel unabhängig voneinander behandelt werden, werden sie manchmal nicht auf die Gesamtanzahl der Artikel angerechnet. Wenn Sie diese Option aktivieren, werden die einzigartigen Gegenstandsstatistiken vollständig ignoriert und alle gleich behandelt, solange sie denselben Gegenstandsnamen haben.

Wenn Du diese Option deaktivierst, werden die Artikelanzahlen unabhängig angezeigt, da die Artikelstatistiken berücksichtigt werden. Gegenstandssummen werden nur für jeden Charakter angezeigt, der denselben einzigartigen Gegenstand mit exakt denselben Werten hat. |cFFDF2B2B(Nicht empfohlen)|r
]]
L.DisplayShowUniqueItemsTotalsTitle = "QuickInfo Gesamtsummen für einzigartige Gegenstände anzeigen"
L.DisplayShowUniqueItemsEnableText = "Aktiviere einzigartige Artikelsummen"
L.ColorPrimary = "Primärer BagSync Tooltipfarbe"
L.ColorSecondary = "Sekundär BagSync Tooltipfarbe"
L.ColorTotal = "BagSync [Total] Tooltipfarbe"
L.ColorGuild = "BagSync [Gilde] Tooltipfarbe"
L.ColorCrossRealm = "BagSync [Cross-Realms] Tooltipfarbe"
L.ColorBNET = "BagSync [Battle.Net] Tooltipfarbe"
L.ColorItemID = "BagSync [ItemID] Tooltipfarbe"
L.ConfigHeader = "Einstellungen für verschiedene BagSync Funktionen."
L.ConfigDisplay = "Display"
L.ConfigTooltipHeader = "Einstellungen für die angezeigten BagSync Tooltip Informationen."
L.ConfigColor = "Farbe"
L.ConfigColorHeader = "Farbeinstellungen für BagSync Tooltip Informationen"
L.ConfigMain = "Hauptkonfig"
L.ConfigMainHeader = "Haupteinstellungen von BagSync"
L.ConfigSearch = "Suche"
L.ConfigSearchHeader = "Einstellungen für das Suchfenster"
L.WarningItemSearch = "WARNUNG: Insgesamt [|cFFFFFFFF%s|r] Elemente wurden nicht durchsucht!\n\nBagSync wartet immer noch auf die Antwort des Servers/Cache.\n\nDrücke die Suchen- oder Aktualisieren Taste."
L.WarningUpdatedDB = "Du wurdest auf die neueste Datenbankversion aktualisiert! Alle Deine Charaktere müssen erneut gescannt werden!|r"
L.WarningHeader = "Warnung!"
L.ConfigFAQ= "FAQ / Hilfe"
L.ConfigFAQHeader = "Häufig gestellte Fragen und Hilfebereich für BagSync."
L.FAQ_Question_1 = "Ich erlebe Ruckeln/Stottern/Verzögerungen bei Tooltips."
L.FAQ_Question_1_p1 = [[
Dieses Problem tritt normalerweise auf, wenn alte oder beschädigte Daten in der Datenbank vorhanden sind, die BagSync nicht interpretieren kann. Das Problem kann auch auftreten, wenn BagSync eine überwältigende Datenmenge verarbeiten muss. Wenn Sie Tausende von Elementen über mehrere Charaktere hinweg haben, müssen Sie innerhalb einer Sekunde eine Menge Daten durchgehen. Dies kann dazu führen, dass Ihr Kunde für einen kurzen Moment stottert. Schließlich ist ein extrem alter Computer eine weitere Ursache für dieses Problem. Bei älteren Computern kommt es zu Ruckeln/Stottern, da BagSync Tausende von Artikel- und Charakterdaten verarbeitet. Neuere Computer mit schnelleren CPUs und Arbeitsspeicher haben dieses Problem normalerweise nicht.

Um dieses Problem zu beheben, kannst Du versuchen, die Datenbank zurückzusetzen. Dies behebt normalerweise das Problem. Verwende den folgenden Slash-Befehl. |cFF99CC33/bgs resetdb|r
Wenn dies Dein Problem nicht löst, reiche bitte ein Problemticket auf GitHub für BagSync ein.
]]
L.FAQ_Question_2 = "Keine Gegenstandsdaten für meine anderen WOW-Konten in einem |cFFDF2B2Bsingle|r |cff3587ffBattle.net|r-Konto gefunden."
L.FAQ_Question_2_p1 = [[
Addons haben nicht die Fähigkeit, Daten von anderen WOW-Konten zu lesen. Dies liegt daran, dass sie nicht denselben SavedVariable-Ordner gemeinsam nutzen. Dies ist eine eingebaute Einschränkung im WOW-Client von Blizzard. Daher können Sie Artikeldaten für mehrere WOW-Konten unter einem |cFFDF2B2Bsingle|r |cff3587ffBattle.net|r nicht sehen. BagSync kann nur Charakterdaten über mehrere Realms innerhalb desselben WOW-Kontos lesen, nicht das gesamte Battle.net-Konto.

Es gibt eine Möglichkeit, mehrere WOW-Konten innerhalb eines |cFFDF2B2Bsingle|r |cff3587ffBattle.net|r-Kontos zu verbinden, sodass sie denselben SavedVariables-Ordner teilen. Dazu gehört das Erstellen von Symlink-Ordnern. Ich werde diesbezüglich keine Hilfe leisten. Also frag nicht! Weitere Informationen findest Du in der folgenden Anleitung. |cFF99CC33https://www.wowhead.com/guide=934|r
]]
L.FAQ_Question_3 = "Kannst Du Gegenstandsdaten von |cFFDF2B2Bmehreren|r |cff3587ffBattle.net|r Accounts anzeigen?"
L.FAQ_Question_3_p1 = "Nein, das ist nicht möglich. Ich werde dabei keine Hilfe leisten."
L.FAQ_Question_4 = "Kann ich Artikeldaten von mehreren WOW-Konten anzeigen, |cFFDF2B2Bderzeit eingeloggt|r?"
L.FAQ_Question_4_p1 = "Derzeit unterstützt BagSync die Übertragung von Daten zwischen mehreren angemeldeten WOW-Konten nicht. Dies kann sich in Zukunft ändern."
L.FAQ_Question_5 = "Warum erhalte ich eine Meldung, dass das Scannen der Gildenbank unvollständig ist?"
L.FAQ_Question_5_p1 = [[
BagSync muss den Server nach |cFF99CC33ALL|r deiner Gildenbankdaten abfragen. Es dauert einige Zeit, bis der Server alle Daten übertragen hat. Damit BagSync alle Ihre Artikel ordnungsgemäß speichern kann, müssen Sie warten, bis die Serverabfrage abgeschlossen ist. Wenn der Scanvorgang abgeschlossen ist, benachrichtigt BagSync Sie im Chat. Wenn Sie das Gildenbank-Fenster verlassen, bevor der Scanvorgang abgeschlossen ist, werden falsche Daten für Ihre Gildenbank gespeichert.
]]
L.FAQ_Question_6 = "Warum sehe ich [FakeID] anstelle von [ItemID] für Kampfhaustiere?"
L.FAQ_Question_6_p1 = [[
Blizzard weist Kampfhaustieren keine ItemIDs für WOW zu. Stattdessen wird Battle Pets in WOW eine temporäre PetID vom Server zugewiesen. Diese PetID ist nicht eindeutig und wird geändert, wenn der Server zurückgesetzt wird. Um Battle Pets im Auge zu behalten, generiert BagSync eine FakeID. Eine FakeID wird aus statischen Nummern generiert, die dem Battle Pet zugeordnet sind. Die Verwendung einer FakeID ermöglicht es BagSync, Battle Pets sogar über Server-Resets hinweg zu verfolgen.
]]
L.FAQ_Question_7 = "Was ist ein genaues Scannen von Kampfhaustieren in Gildenbank und Postfach?"
L.FAQ_Question_7_p1 = [[
Blizzard speichert Kampfhaustiere nicht mit einer korrekten ItemID oder SpeciesID in der Gildenbank oder Mailbox. Tatsächlich werden Kampfhaustiere in der Gildenbank und im Postfach als |cFF99CC33[Haustierkäfig]|r mit der ItemID |cFF99CC3382800|r gespeichert. Dies macht es für Addon-Entwickler schwierig, Daten zu bestimmten Kampfhaustieren zu erhalten. Dies zeigt sich auch im Log der Gildenbank, dort werden Kaupfhaustiere als |cFF99CC33[Haustierkäfig]|r angezeigt. Auch beim Verlinken aus der Gildenbank werden sie als |cFF99CC33[Haustierkäfig]|r angezeigt. Um dieses Problem zu umgehen, gibt es zwei Methoden. Die erste Methode besteht darin, das Kampfhaustier einem Tooltip zuzuweisen und dann die SpeciesID von dort zu holen. Dafür muss der Server auf den WoW-Client antworten. Das kann zu massiven Lags führen, insbesondere wenn sich viele Kampfhaustiere in der Gildenbank befinden. Die zweite Methode verwendet die Symboltextur des Kampfhaustiers, um die SpeciesID herauszufinden. Dies ist manchmal ungenau, da manche Kampfhaustiere die gleiche Symboltextur haben. Beispiel: Giftmüllschleimling verwendet die gleiche Symboltextur wie Jadeschlammling. Aktivieren dieser Option erzwingt die Tooltip-Scanmethode für möglichst genaue Ergebnisse, kann aber Lags verursachen. |cFFDF2B2BDaran führt kein Weg vorbei, bis Blizzard uns mehr Daten zum Arbeiten gibt.|r
]]
