namespace CodeFirstVidzy.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class PopulateGenresTable : DbMigration
    {
        public override void Up()
        {
            Sql("INSERT INTO Genres (name) VALUES ('Romance ')");
            Sql("INSERT INTO Genres (name) VALUES ('??????? ')");
            Sql("INSERT INTO Genres (name) VALUES ('Action  ')");
            Sql("INSERT INTO Genres (name) VALUES ('Horror  ')");
            Sql("INSERT INTO Genres (name) VALUES ('Thriller')");
            Sql("INSERT INTO Genres (name) VALUES ('Comedy  ')");
            Sql("INSERT INTO Genres (name) VALUES ('Family  ')");
        }
        
        public override void Down()
        {
        }
    }
}
