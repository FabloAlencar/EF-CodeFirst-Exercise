﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'CodeFirstVidzy.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '202001252136305_InitialModel'
BEGIN
    CREATE TABLE [dbo].[Genres] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Genres] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[Videos] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        [ReleasedDate] [datetime] NOT NULL,
        CONSTRAINT [PK_dbo.Videos] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoGenres] (
        [Video_Id] [int] NOT NULL,
        [Genre_Id] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoGenres] PRIMARY KEY ([Video_Id], [Genre_Id])
    )
    CREATE INDEX [IX_Video_Id] ON [dbo].[VideoGenres]([Video_Id])
    CREATE INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]([Genre_Id])
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id] FOREIGN KEY ([Video_Id]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoGenres] ADD CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202001252136305_InitialModel', N'CodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D64AB297AD61EF22759222E8260EE224E82DA0A5B14394A254920AEC2DFA643DF491FA0A1DEA5FA4644BEE222DDA22406093F33F1F8733F41FBFFD3EF9B00999F30242D2884FDD93D1B1EB00F7A380F2F5D44DD4EACD3BF7C3FB2FBF985C04E1C6792CE8DE6A3AE4E472EA3E2B158F3D4FFACF1012390AA92F2219ADD4C88F428F0491777A7CFCAD7772E2018A705196E34CEE12AE6808E917FC3A8BB80FB14A08BB8E0260325FC79D452AD5B92121C898F830756748714985548F34F8B4759D3346095AB100B6721DC279A488421BC70F12164A447CBD887181B0FB6D0C48B7224C426EFBB822EFEBC6F1A976C3AB180B517E2255140E1478F2368F8B67B21F145DB78C1B46EE0223ACB6DAEB347A53F77BE0023D37358D674C682A33B2A394FEC869AE1E951840A8E83F2448984A044C39244A1076E4DC264B46FD1F607B1FFD047CCA13C6EA96A16DB8D758C0A55B11C520D4F60E56B9BD5781EB784D3ECF642CD96A3C9933575CBD3D759D1B544E960CCAC4D71C5FA848007A098228086E895220B8960169E82CED862EFDBFD08648C303E33AD764F311F85A3D4F5DFCE83A97740341B1925BF0C0299E2F645222014BC90D79A1EBD43E431D861F22E93A77C0D26DF94CE30CF6A374EB29CD17125C8A28BC8B58C192AF3FDD13B1068506472D9B8B2811BE61CCC4AB20B41358A9A401C04AE9FF07D62B03CB5082300222213847130B65FAF33DD5CA2DEFFAA2B400E1A1282D80D88AD202C27D507A2665E4D3D4863A4C0BFD4D772E78E0EC32264B45E904A603A1496304236A9EBADF58F1E910589EC14A605E95770A9C78356FECA388B7A72214D15639FA697BBED4CBB0512D0713AFC6FC6CCA1C2CA6F55AEC029491D42AD24DE32DE79BEC45E5B2D8F3601AEC355F0D1925786A246DE0324BC09EF496F656A67A3D451409AD89286C342B4CD3AD16049769ACBA1F2F6B7F8A36C9EBE89326D7248EB14CD4FAA67CC559E44DD39BC5F08E22CC6478BE6C692C4A6B4B4D58F4C81A8CDD5AF1C7EA429644179359105A6406683B1055286BE0D2CE5581B3825C7FCE58DA7A1C534015BE4BF428C4A29D3A0766926DBEB461258C8896DB6316B124E45D37D02EEEEC3EA8F3672BB6848967186E86C6B36263A0D48C74AF3CE4A7E62FE421AB04C3F3D0C1F777E7A14B42F3D2AD4B6AEEBC7E669BD5A925BD65EDDD9DC392AC3553ADC746D7D6B65ED728D376487AA53813D596681D9252F1409BF2BA7FA04DA99081369917889D45EB1E31494A0C95F789716F4CF21A3E60082F8A7A46E23A68FB0B060A0BFA622B1584234D305AFCCC668C226A2B826BC2E90AA4CA5A791767E1536396FFE7CCD59E9401EB335CBFFA30427548F78E1BFBBAF91DF3077F21C27F26E2AB906CBEAE4BB2678C81F3E27F3A56FDE6B1003FABFDF3D8B0C01F8CD41D95D426EE2A71FB1356A9A9A5CD1A61AE78009BA9FB4BCA3476AE7E7C2AF88E9CB9C0FA32768E9D5F07A7B3327B98F2826F80F2C306D7D6DBD09C4EF64FAC27D6253CE7E7884005CE999F95D919913E09EC88E91B6AA7F67C28344DE833E8EA97615881D0879130BCC8A412789559CDCEADA0DCA731610DAFEDDBB84F09D12E95F2CC9D738881EBDA603BD847DBAEE6A3146D84775F003A1F03F600A7AD65A9A5CECE5A6BC2FE65C0E99FCAD705CEAE0EF1B303A7FD15C99EDB7B3C1275BF11650D22DE694B5D9EB2AAD8F154D2FA7ED4FD7CD426B9FD1DA75D7297E1F5CD4E1D1D2EEC7DC32A1F9F763F65750C3F76C1B766E2BD4F580DB7CD11ADFFEB552F678B67B23DCEB64F557691B21E625ECBD9014F75F6288527B4F6AB27560849D79508FD1B2807BF71364B9A2BBE8A8A2261585490188DCC352882ED2339138AAE88AF70DB0729D3DF121E094B90E4225C4270C5E7898A13852E43B8648DDF2674A9D9A53F7D8F6CDA3C99C7E9ABFFE77001CDA4BA039EF3EF12CA82D2EECB965EAA4384AE6179B3AF73A974D3BFDE96926E22DE53501EBEB2F4DE4318331426E77C415EE010DB1E247C8435F1B7C544DC2D647F229A619F9C53B2162494B98C8A1FBF22868370F3FE4FC0A80A97FC1F0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202001252137239_PopulateGenresTable'
BEGIN
    INSERT INTO Genres (name) VALUES ('Romance ')
    INSERT INTO Genres (name) VALUES ('??????? ')
    INSERT INTO Genres (name) VALUES ('Action  ')
    INSERT INTO Genres (name) VALUES ('Horror  ')
    INSERT INTO Genres (name) VALUES ('Thriller')
    INSERT INTO Genres (name) VALUES ('Comedy  ')
    INSERT INTO Genres (name) VALUES ('Family  ')
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202001252137239_PopulateGenresTable', N'CodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D64AB297AD61EF22759222E8260EE224E82DA0A5B14394A254920AEC2DFA643DF491FA0A1DEA5FA4644BEE222DDA22406093F33F1F8733F41FBFFD3EF9B00999F30242D2884FDD93D1B1EB00F7A380F2F5D44DD4EACD3BF7C3FB2FBF985C04E1C6792CE8DE6A3AE4E472EA3E2B158F3D4FFACF1012390AA92F2219ADD4C88F428F0491777A7CFCAD7772E2018A705196E34CEE12AE6808E917FC3A8BB80FB14A08BB8E0260325FC79D452AD5B92121C898F830756748714985548F34F8B4759D3346095AB100B6721DC279A488421BC70F12164A447CBD887181B0FB6D0C48B7224C426EFBB822EFEBC6F1A976C3AB180B517E2255140E1478F2368F8B67B21F145DB78C1B46EE0223ACB6DAEB347A53F77BE0023D37358D674C682A33B2A394FEC869AE1E951840A8E83F2448984A044C39244A1076E4DC264B46FD1F607B1FFD047CCA13C6EA96A16DB8D758C0A55B11C520D4F60E56B9BD5781EB784D3ECF642CD96A3C9933575CBD3D759D1B544E960CCAC4D71C5FA848007A098228086E895220B8960169E82CED862EFDBFD08648C303E33AD764F311F85A3D4F5DFCE83A97740341B1925BF0C0299E2F645222014BC90D79A1EBD43E431D861F22E93A77C0D26DF94CE30CF6A374EB29CD17125C8A28BC8B58C192AF3FDD13B1068506472D9B8B2811BE61CCC4AB20B41358A9A401C04AE9FF07D62B03CB5082300222213847130B65FAF33DD5CA2DEFFAA2B400E1A1282D80D88AD202C27D507A2665E4D3D4863A4C0BFD4D772E78E0EC32264B45E904A603A1496304236A9EBADF58F1E910589EC14A605E95770A9C78356FECA388B7A72214D15639FA697BBED4CBB0512D0713AFC6FC6CCA1C2CA6F55AEC029491D42AD24DE32DE79BEC45E5B2D8F3601AEC355F0D1925786A246DE0324BC09EF496F656A67A3D451409AD89286C342B4CD3AD16049769ACBA1F2F6B7F8A36C9EBE89326D7248EB14CD4FAA67CC559E44DD39BC5F08E22CC6478BE6C692C4A6B4B4D58F4C81A8CDD5AF1C7EA429644179359105A6406683B1055286BE0D2CE5581B3825C7FCE58DA7A1C534015BE4BF428C4A29D3A0766926DBEB461258C8896DB6316B124E45D37D02EEEEC3EA8F3672BB6848967186E86C6B36263A0D48C74AF3CE4A7E62FE421AB04C3F3D0C1F777E7A14B42F3D2AD4B6AEEBC7E669BD5A925BD65EDDD9DC392AC3553ADC746D7D6B65ED728D376487AA53813D596681D9252F1409BF2BA7FA04DA99081369917889D45EB1E31494A0C95F789716F4CF21A3E60082F8A7A46E23A68FB0B060A0BFA622B1584234D305AFCCC668C226A2B826BC2E90AA4CA5A791767E1536396FFE7CCD59E9401EB335CBFFA30427548F78E1BFBBAF91DF3077F21C27F26E2AB906CBEAE4BB2678C81F3E27F3A56FDE6B1003FABFDF3D8B0C01F8CD41D95D426EE2A71FB1356A9A9A5CD1A61AE78009BA9FB4BCA3476AE7E7C2AF88E9CB9C0FA32768E9D5F07A7B3327B98F2826F80F2C306D7D6DBD09C4EF64FAC27D6253CE7E7884005CE999F95D919913E09EC88E91B6AA7F67C28344DE833E8EA97615881D0879130BCC8A412789559CDCEADA0DCA731610DAFEDDBB84F09D12E95F2CC9D738881EBDA603BD847DBAEE6A3146D84775F003A1F03F600A7AD65A9A5CECE5A6BC2FE65C0E99FCAD705CEAE0EF1B303A7FD15C99EDB7B3C1275BF11650D22DE694B5D9EB2AAD8F154D2FA7ED4FD7CD426B9FD1DA75D7297E1F5CD4E1D1D2EEC7DC32A1F9F763F65750C3F76C1B766E2BD4F580DB7CD11ADFFEB552F678B67B23DCEB64F557691B21E625ECBD9014F75F6288527B4F6AB27560849D79508FD1B2807BF71364B9A2BBE8A8A2261585490188DCC352882ED2339138AAE88AF70DB0729D3DF121E094B90E4225C4270C5E7898A13852E43B8648DDF2674A9D9A53F7D8F6CDA3C99C7E9ABFFE77001CDA4BA039EF3EF12CA82D2EECB965EAA4384AE6179B3AF73A974D3BFDE96926E22DE53501EBEB2F4DE4318331426E77C415EE010DB1E247C8435F1B7C544DC2D647F229A619F9C53B2162494B98C8A1FBF22868370F3FE4FC0A80A97FC1F0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202001252146294_UpdateGenresToGenreInVideosTables'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Videos_Video_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Videos_Video_Id]
    IF object_id(N'[dbo].[FK_dbo.VideoGenres_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[VideoGenres] DROP CONSTRAINT [FK_dbo.VideoGenres_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Video_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Video_Id] ON [dbo].[VideoGenres]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[VideoGenres]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[VideoGenres]
    ALTER TABLE [dbo].[Videos] ADD [Genre_Id] [int]
    CREATE INDEX [IX_Genre_Id] ON [dbo].[Videos]([Genre_Id])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id] FOREIGN KEY ([Genre_Id]) REFERENCES [dbo].[Genres] ([Id])
    DROP TABLE [dbo].[VideoGenres]
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202001252146294_UpdateGenresToGenreInVideosTables', N'CodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400ED59DB6EE336107D2FD07F10F4D41659CBC9BEB486BD8BD4490AA39B0BA224E85B404B63872845AA2415D85BF4CBFAD04FEA2F74A89B255276646F372DD02240E0903367AE9C8BF3E7EF7F8CDFAF12E63D835454F0897F3C18FA1EF048C4942F277EA6176FBEF5DFBFFBF28BF1799CACBC878AEEADA1434EAE26FE93D6E9280854F40409518384465228B1D083482401894570321C7E171C1F0780103E6279DEF836E39A2690FF817F4E058F20D51961972206A6CA73BC097354EF8A24A05212C1C49F22C505954A3FD0F8E3DAF74E1925A845086CE17B8473A189461D47F70A422D055F86291E1076B74E01E916842928751F6DC8FB9A313C3166041BC60A2ACA9416C99E80C76F4BBF0436FB41DEF56BBFA1E7CED1C37A6DACCEBD37F17F002ED1725BD268CAA4A1B23D3BC8E98FBCF6E9519D03982AE6070932A63309130E9996841D7937D99CD1E84758DF899F814F78C6585333D40DEF5A07787423450A52AF6F6151EA3B8B7D2F68F3053663CDD6E0298C9971FDF6C4F7AE50389933A803DF303CD442025A099268886F88D620B9C180DC758E744B96F95D49C34CC307E37B9764F501F8523F4D7CFCE87B1774057175526A70CF29BE2F64D23283B69071B089DACE58622C40EC11CB9CFEFF58BE662C5D21B7C0802888CF50C54A98F97C478D70C73A0BEC8A3CD3656EAC055BBE6B44CF6FD5134D8B725844FDB1BCBF9022B915AC4A9EE2F83114998C8C36C2BDBB237209BA5F869E2A25229A2BD04CD15278DB92731E7B3B34298250EB8F81C0A4A429A621CA9DF8DF389EE9C6ABB46FE0959E68E30D078363DBC68635EE33C466A509C54CDB18FA717D3637C7B0D21D8F123B51F92E559928B6FE063604DD0CA8F2BD8DA7DBFA3BE6B7D9732774B197EEB4D81BB65A1855E634283A12CB7EFCBBA35B2BBBD133E88750C5B3815039CAAE2C6D933AB2B70EE166D0088A49A39A48822D23C9F892A4299687C688529E7861399FBC09F76FDE49811144AAA387D7DAD692B0D8912558B78DA28F5585CC892922D33871C8AC84DD924D95B0564EBAA1AA72AC22379F0B96AE71C206D8B8EF022D4AB058E7C6811D64972F9F0D0923B2A36B4C05CB12BEADF3ECE22EFA4093BF387111C681A5B8ED9AC0F18D95A5B6A77BC5A17C349F1087A20AEC1F872D7CFF741CB621B49B6D13A97DF3FA916D57A78EF056757777082BAA5E713235D57250476D755DD12BB4054657808D2B6AB9FBA954368C0355DA5B192C8631CDA797993293583D85F531D4EE386ED89DC66393D449573720ABD18CCBA2BFC7825C758182C4F7D0F667F430768070AD3424034330087F61534631CD37049784D305285DCCFC3EEEA927D69EFDEFD97903A562D667F17DF5AD851A97BEB897BC34F6EF5854F83391D113915F2564F57513E99317CBFFB4AFFA2D6E317ED6BD16B7AE75EDD132DDD919663C86D5C4FF35671A79B39F1E2BBE23EF5AE21B1D7943EFB7C3827ED8AED6684AFBAD53EE447FC892879906D22402615844959658469DCE7C839B7B4453C25A3ABB3DA44FFA1AFFD578F6CD19A4C04D5EB6CCEA236857B3AC51AD77F492ED7B2EACEE9AD0631FDDBE8E16ED055FC4DC04B648C62D9B59E7AABA7D53ED42EEDE1A3FE316DBB2BEB191BCB8B7BACBEEE7D954DDC10033A6F1FD3A26ABA2CB0D8499753844AD5CA969667C21AAA4B534AA48AC7A76099A603124A752D30589345E47A054FE15DA036119929C27738867FC3AD369A6D16448E6ACF5959C49FD5DF2F375BCADF3F83ACDBFEDFA3B4C4035A9A9E7D7FCFB8CB2B8D6FBC2ADE7DB20CC9B2A5B9789A5362D6CB9AE91AE04EF0954BAAF2E057790A40CC1D4350FC9331CA2DBBD820FB024D1BA9AEFB683BC1C88B6DBC767942C25495489B1E137FF330ACC3F8DDEFD05A3B35AD9661A0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202001252211539_AddClassificationCollumnToVideosTables'
BEGIN
    ALTER TABLE [dbo].[Videos] ADD [Classification] [tinyint] NOT NULL DEFAULT 0
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202001252211539_AddClassificationCollumnToVideosTables', N'CodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400ED59CD6EE33610BE17E83B083AB545D6B2934B6BD8BBC83AC9C2E83A09A224E82DA0A5B14394A254920AEC167DB21EFA487D850E25EA8F921D399BDD1668B1C0C2226786F3F3717E98BFFEF873F26E1331E70984A4319FBAA3C1D07580077148F97AEAA66AF5E67BF7DDDBAFBF9A9C87D1C6B92FE84E341D727239751F954AC69E27834788881C443410B18C576A10C49147C2D83B1E0E7FF046230F50848BB21C677293724523C83EF07316F300129512B6884360D2ACE38E9F49752E49043221014CDD19525C5021D53D0D7FDDBACE29A304B5F081AD5C87701E2BA250C7F19D045F8998AFFD041708BBDD2680742BC22418DDC715795F3386C7DA0CAF622C4405A9547174A0C0D189F18B67B3BFC8BB6EE937F4DC397A586DB5D599F7A6EE07E0022DB74F1ACF98D054B6670719FD91D35C3D2A318050D1FF9020652A1530E5902A41D891739D2E190D7E84ED6DFC33F0294F19AB6B86BAE15E630197AE459C8050DB1B58197DE7A1EB784D3ECF662CD96A3CB93173AE4E8E5DE7120F274B0665E06B86FB2A16805682200AC26BA21408AE6540E6BAD6E9D659FAFFE234441A5E18D75990CD47E06BF53875F1A7EB5CD00D84C58AD1E08E53BC5FC8A4440ACD43265E15B5BDB1C458407C402C33FAFF63F92563D93EE406181009E119AA581CA67FDF527D78CBBAFDC2668C4849573430E9C2E88E5970606F3D27F9923CD175466B9D613206EA9DEDCA479A9823323C3D98FD0B114737312B60992F3FF8712A026D67DCDEBB25620DAA2FF6D3A8867CDBB8B9BC60645D25F6DE57A229E8B5EE06222204C1B688A0FCD4F75B0C76D3DF0B8896208C3D3E65587D5DE79EB0143F47ADE834A83FC42C2C698FF7D35EEBA8A1F34AFA93B6C373D7D6174FA58C039AF9A49E6B4CAC9BC79DF3D0D913F80A91265D2DD08334419F6198A7EE772DF5BBE51560A9C933C06BCA1B0E0623DBC29A35ED7C8A5D872294970ECB027FB6D4CBB0511D50C296C2A0499A1B6FEBAFC5FAA0EAF747BA4E05ECA6FE2DF39BEC9913BAD88D3B2DF69AAD968CE2A2D6283AEEB19DC5F747B754B6D2D3EB27A188674D42E128BB44344DEA48166508AB8ED1CB5BC6A2B5F476F49693054912BCA5B55ED3AC38BE6934DFF8877761512EC30B644733566A5B9E84558BACC1DAADA52A2C0F6449745E9B85518BCC02EC0E3415873530D90E5581B1825CFF3629B7A32FB40554EEBB408B22ACBA99716007B9CD9735F98411D151FE67314B23BEAB85D8C79D17F43A7FBED29630F12CC56DD7782DDF5828B53DDD2B0EE6D27C421CF22C70781C76F0FDD371D825A1D935D5253577FA4BB45B88BA4C7BEFCBE3A599F33A405364F3FDC028A87A455F676ACB491D19BBED8A5E80C96574C146BBA23CF730954C197AA14A072B832936A4594F3497BA9D2EDBCD3E86DA75AC1DF65639B3494AD09565CD2A5F13534A0E783F296A4B4EE23A68FB137A18EB8ABF950AA2812618F8BFB019A308F38A6041385D815479DBEB1E0F47C7D633CCBFE749C49332647DDE45BEF8504BB54B9F1D5B0F9C0AEB732C7F22227824E29B886CBEAD4BFAE47787FFB4AFFACDF521FE56AF37D7E320B7CD9C70A0B42A25D51CD99A6BE638B36EA6EE6F19D3D899FFF450F01D3957026FFCD8193ABFBF0C422F9B276B25EEB091AF3D75BC641045DC82D0B0220C53B2C4719FB6EBFCB5A03CA009610D9DDB15A9CF65D0FE2BE5D93B679000D7286F98D5E7A07DA5B7946ADDCAE76C3F70A86E8F323D66E6DD23735EACF07E2D75607330EE981E3BC7E9DDD37497E4EEC9F6334EDA0DEB6B53D3B3B3757B20FF3CD374BBCD40C4D4FE98836095745D89D09D1387A081959266CE5771015A4BA382C4CA670B5004532B39158AAE48A0703B00CC97FABDD6BC729D474B08E7FC2A5549AAD0648896ACF1FEABA1BFEFFCECC9A0A9F3E42AC91E405FC3045493EAEA70C5DFA7B4F69A77D1CEE7BB44E83B650AA18EA5D20571BD2D255DC6BCA720E3BE3215DC4294301426AFB84F9EE025BADD49F8086B126C8B6E71B790E703D174FBE48C92B5209134322A7EFC440C87D1E6EDDFC90E90A5D31C0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202001261720222_AddEntityTypeConfigurations'
BEGIN
    IF object_id(N'[dbo].[FK_dbo.Videos_dbo.Genres_Genre_Id]', N'F') IS NOT NULL
        ALTER TABLE [dbo].[Videos] DROP CONSTRAINT [FK_dbo.Videos_dbo.Genres_Genre_Id]
    IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Genre_Id' AND object_id = object_id(N'[dbo].[Videos]', N'U'))
        DROP INDEX [IX_Genre_Id] ON [dbo].[Videos]
    EXECUTE sp_rename @objname = N'dbo.Videos.Genre_Id', @newname = N'GenreId', @objtype = N'COLUMN'
    ALTER TABLE [dbo].[Genres] ALTER COLUMN [Name] [nvarchar](255) NOT NULL
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [Name] [nvarchar](255) NOT NULL
    ALTER TABLE [dbo].[Videos] ALTER COLUMN [GenreId] [int] NOT NULL
    CREATE INDEX [IX_GenreId] ON [dbo].[Videos]([GenreId])
    ALTER TABLE [dbo].[Videos] ADD CONSTRAINT [FK_dbo.Videos_dbo.Genres_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genres] ([Id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202001261720222_AddEntityTypeConfigurations', N'CodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400ED595F6FDB36107F1FB0EF20E87148ADD841812DB05BA44E5218ABE3204A82BD05B47476885194465281DD619F6C0FFB48FB0A3B4A942C5192637B49BB014580C026EF1FEF7E77BCA3FFFEF3AFE1FB55C49C271092C67CE4F67BC7AE033C8843CA972337558B373FBAEFDF7DFFDDF0228C56CE7D4177A2E99093CB91FBA85472EA7932788488C85E440311CB78A17A411C79248CBDC1F1F14F5EBFEF018A705196E30C6F52AE6804D917FC3A8E7900894A099BC6213069D671C7CFA43A57240299900046EE18292EA990EA9E869FD7AE73C628412B7C600BD7219CC78A28B4F1F44E82AF44CC977E820B84DDAE1340BA0561128CEDA71BF25D8F713CD0C7F0368C85A820952A8EF614D83F317EF16CF683BCEB967E43CF5DA087D55A9F3AF3DEC8FD085CE0C96D4DA763263495EDD95E467FE4D4578F4A0C2054F41F12A44CA502461C5225083B72AED339A3C1CFB0BE8D7F053EE2296355CBD036DCAB2DE0D2B58813106A7D030B63EF24741DAFCEE7D98C255B85273FCC84AB9381EB5CA17232675006BE72705FC502F094208882F09A2805826B1990B9AEA1DDD2A5FF17DA10699830AE3325AB4FC097EA71E40EDEBE759D4BBA82B0583116DC718AF9854C4AA4D062A1A5F58A3CD16566B0A51FE301B1749D1B60D9B67CA4499E07BD6CEBC104FC52C4D14DCC0A8E7CF9E196882528B43F6EEEF9712A02CB92A1B701D456986582F6805946FF0D665F1B66965604151009E139DA5C68D79F6F69B4BFB00C55CFFB6CBB90312352D2050D4C7D341ED170B7B70E4E29933187655491356D195564DB6E199546957CB20F3791978C2C3737D9CE895617F4521987380B41B035E232D7FA618D88A9FB7B0AD11C84398F4F19B61BAE734F588A5FFB8DE8D4A83FC62C2C6907DB69AF75D4D07925FD49D3E1B96BAB8B6752C601CD7C52AD6026D67575173C74B6047E83485304A7E8419AA0CF30CC23F78786F9EDF2CAD2BC9167805797D777EDEA36E3E798B70A9CB320EF41C64406246C66007A22ACAF604104A12B1261D88D490C38E5AA593D290F684258B7D516CB8E25579B540AB777CE2101AEAB65B7EF77D15A56A1A6EA5283E5A5E79C32F42AE869DE8AC8A390A304689668E773BD0C2BD592BAD8B39AEC95A66EDB78D1627D50D523610BB0292475BC34E056672F3A8806BB81AFC55E39AB25A3288C158A96BA69BB7D7B3695C66EEC6C046E7BFE5424148EB2D3A07EA496E25C8670339278F94C52CC2E5EC7F0329C9224C1AA581966CC8AE39B49E68DBF7F9B1FE532BC40B674FBA5B5A526EC3DC812ACDDCAD580773A99137D8F8CC3A8416601B6034D85B21A269BA12A305690EBCFE68A6B193C5A52DA305EE289225D0DB2C6CA0E72932F9B220923A2A5891BC72C8D787755EAE6CEDBB22A7FBED29430F42CC31BE5A7E19B46B1AE7B7AA73898A4F91771C8ABC0FE71E8E0FBDA71E892506F75AB92EA3BBB4B2C6F9AAAB0CEEBA75B8EDDFA55C5D97B5F18778DFA689394DACB3A69D5C3A1A94D7BBCF814C52A27711D74D713620D0B95BF960AA29E26E8F9BFB131A378DE0DC19470BA00A9F2BED51D1CF707D6C3D17FE711C7933264BBBCE47CF159976A973E3BCDEE39D655C75BFE4444F0484473C0DD2A74CFA7896F7EEB14DA36F587F859BDC0D49F79A1D1F14EB0ED5E8DDCDF339E5367F2CB83613B72660233F7D43976FE78A1B7021C0ED7991507A1E9B039D134C65F7494B3BAE24306D383A6C1AEBEED7506C0FFC9CCD7ECB47718E9BA27BAFCEAC3AC9CEBB8E620EE186E5AA7BDEE61AF4D72FBE0F58A8360EDF495A6FED9D1AF392FBECEB0D76C5A1031951FB310AB922E3722F44F5B1C821A564A9A095FC405662D8B0A12ABB04D41112CC8E44C28BA2081C2ED00B0D4E94761F3E87511CD219CF059AA9254E191219AB3DA23B386FE36FDD9445BB779384BB2F7D09738029A49F59D32E31F525A79DCBB6C29C51D22744E99AB54C752E92B75B92E255DC57C4741C67D6529B8852861284CCEB84F9EE010DBEE247C822509D645EFD92DE4F940D4DD3E3CA7642948248D8C0D3F7E450C87D1EADD3FAB1A3DBFD31D0000 , N'6.1.3-40302')
END

IF @CurrentMigration < '202001261740023_AddingTagsTable'
BEGIN
    CREATE TABLE [dbo].[Tags] (
        [Id] [int] NOT NULL IDENTITY,
        [Name] [nvarchar](max),
        CONSTRAINT [PK_dbo.Tags] PRIMARY KEY ([Id])
    )
    CREATE TABLE [dbo].[VideoTags] (
        [VideoId] [int] NOT NULL,
        [TagId] [int] NOT NULL,
        CONSTRAINT [PK_dbo.VideoTags] PRIMARY KEY ([VideoId], [TagId])
    )
    CREATE INDEX [IX_VideoId] ON [dbo].[VideoTags]([VideoId])
    CREATE INDEX [IX_TagId] ON [dbo].[VideoTags]([TagId])
    ALTER TABLE [dbo].[VideoTags] ADD CONSTRAINT [FK_dbo.VideoTags_dbo.Videos_VideoId] FOREIGN KEY ([VideoId]) REFERENCES [dbo].[Videos] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[VideoTags] ADD CONSTRAINT [FK_dbo.VideoTags_dbo.Tags_TagId] FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tags] ([Id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'202001261740023_AddingTagsTable', N'CodeFirstVidzy.Migrations.Configuration',  0x1F8B0800000000000400ED1ADB6EDB36F47DC0FE41D0D336A45192A2C016D82D522719823517C469B1B7829668871845692215D81BF6657BD827ED17762851B2C48B2C394EDA1545812226CF8DE74A9EA37FFFFE67F4661953EF01679C246CEC1FEE1FF81E66611211B618FBB998BFF8D17FF3FADB6F466751BCF43E54702F251C60323EF6EF85488F838087F738467C3F266196F0642EF6C3240E5094044707073F0587870106123ED0F2BCD16DCE048971F1037E4E1216E254E4885E2611A65CADC3CEB4A0EA5DA118F3148578EC4F00E29C645C7C20D11F2BDF3BA1048114534CE7BE87184B041220E3F17B8EA7224BD8629AC202A277AB1403DC1C518E95ECC76BF0BEC7383892C708D68815A930E7228907123C7CA9F412E8E85B69D7AFF5069A3B030D8B953C75A1BDB1FF3366199C5CE7743CA19984D235BB5FC0EF79EDD5BDDA07C055E43F00C8A9C8333C66381719A27BDE4D3EA324FC05AFEE92DF301BB39CD2A664201BECB51660E9264B529C89D52D9E2B792F22DF0BDA78818E58A33570CAC35C30F1F2C8F7AE80399A515C1BBE71F0A948320CA7C4191238BA4142E08C491AB8509DC15DE325FFAFB881A741C0F8DE255ABEC36C21EEC7FED1AB57BE774E9638AA569404EF1981F8022491E5D822A1C6F50A3D904521B0C61FEC8113EE7BB79816DBFC9EA4651CEC175B1F95C1CFB324BE4D6885512E7FBC43D9020B903F31F7A6499E859A24A360ED509D6E56101AE06605FC5737FBD46EA67105A7C288E3E81464AEB8CBBFEF483C9C58E1559B75D64D644211E7644E42951F9546A4BBEB5B5B87948A98ED22AA8A1A5B4455D1D657903BB4E88AEC725B1743AE3AA428B66C42F40E6BA03020A801FA6B486F1BD2F067AF90DE59A1E870277B9968795A3F77CAE38633E9017BC1CF2990AC0FDADBCFDA8476E572A0E8086774058629B9BE5D41166C6BFB12C7339CA9F34C09852BB4EF7D4034879F87866D5AD03F2734AA618FBA616FA4C9407935FC4B53E1A56A9B8B279C27212974D2F40195BFDAECCE58E47524B375965585FD12344852D0199879ECFF60886FA757FBD19A9E4AA66D7A87BE1EDED7EC146A91C0DE4958DEAB2788872832FD1F3411B5572023E04C8624A2F0C2E06070C284993E080B498AA85B6A0DA567CE9122D5C4F59D539C6226D3855BF77DB8D695D5645D73D0B4B44929A3A0E13D7D9CAAC81EDD3ED0AE4C8F76A976665A932B6A542731E7E1CAB4050A11A08E3AFA8A2C723A93CB78292C79091E992A3571959575C925D929164D7B41AE5D67C9763018076FA35799DC40578ADC805EE67903B9509B86DA5093C6BEBA0435202C7724DD1DBBB34C2DE8FA88864377E79506854AC77A7A681FA9F7714BA5B94E6B3AFF26F7DFE6AC2D876F102865EB7DD0AA3AD76EBEEEB30465A3A56AC8048E8ECCE812A52994C5468746AD7853D59E79311DDEBB884B1A41C82D2D8C5ADA9A13DCBED0026BBB8DBB013C54D00CC98BC4248A0D302DA81D2153316BC5AD69A72A942A70F9B7BAE358BA29969CAE10CFE144B12C07C5D552F76613AF688D218A32CB357692D03C66EEB2E4C62E2FA64DFC72C5A4300A34C18DFA63E8C6A8D66D4DF7B2838A9847D8A1CC94C3EDE0C0FBD476705168BFDF9B94DA3BFD29D6578D2631E7FDC34D47BFFB37C9E97B9F8DDF39D27C6FAF932576B8CF59B13EB5C73DB505DAD5CB12FEAA227747B802B246B145ADB2E2DA5ECDADD26DAAA297210A42F63B7A83EB20819CEF925E02018961E2E8570AD36EC6CD4207A9BDA6BE6168378991AAEA03064055992F417C0F647F001D41899FAEB8C0F1BE04D89FFE4E2794809FAE012E112373CC45F9E4F78F0E0E8FB439D2E733D309388F689FC1CEB3F7C98854E9C64ED8C02E6FB335C61E5016DEA3CCEC7777121D38A9F8AA372751DB102082BFC50E860085168CF7F4058BF072ECFF59E01C7B17BF7E54687BDE7506917BEC1D787FED687420085B1552ECC69B8CAAF245F9D277315A7EDFA464B6A087C5DD96EA72175313D65AE7366BB76631CC5115DAA31C55493C8C71813480ADCB4EDB358D5537E859FBBA5A7B649B96E256AD61D71BFE69BAC1FFAB06B0F58E3CDC504FE926459B53176073CBF8517384677316FB037348FE7C667FB13D611A16D38D65B1D317E42B7DADF79C9EE27C25EEDC4FECB317B39BEBE8D4B4BFDD704D56CA4722DC5F67320D95C5D13129B04E5DDC43171B657B67DF369071CD636C54ADED7EABB476C2EB2DA7CC56164F370C6A19ADD1EFDE381231E7283B1DF8D4D39AAEB98FA32F345C5447FEB1F5AD767AC86AA2D479487BAF494FD55AD7F2390E38609A65F696205D353E41864CC9C9624D427E90CC70D84A5435CC059B2755BAD424AA40B46BFD251608DECDE82413648E4201DB218617A9FCEE477DD67116CF7074C1AE7391E6028E8CE3196D7D4724F36E17FF6264D79679749D169FFBECE2082026914FFF6BF636278DCF57CE2DEF0B070999D0D52B55DA52C8D7EA625553BA4A584F424A7D751DBAC3714A8118BF6653F480B791ED3DC7EFF00285ABAA45E826B2D9106DB58F4E095A6428E68AC61A1F7E820F47F1F2F57F5ACA1D3D892F0000 , N'6.1.3-40302')
END

