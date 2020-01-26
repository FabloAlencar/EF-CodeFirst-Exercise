using CodeFirstVidzy.EntityConfigurations;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeFirstVidzy
{
    public class VidzyDbContext : DbContext
    {
        public VidzyDbContext()
            : base("name=VidzyDbContext")
        {
        }

        public DbSet<Video> Videos { get; set; }
        public DbSet<Genre> Genres { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new GenreConfiguration());
            modelBuilder.Configurations.Add(new VideoConfiguration());

        }
    }
}
