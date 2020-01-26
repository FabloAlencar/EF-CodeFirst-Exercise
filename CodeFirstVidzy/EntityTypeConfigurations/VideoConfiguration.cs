using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeFirstVidzy.EntityConfigurations 
{
    public class VideoConfiguration : EntityTypeConfiguration<Video>
    {
        public VideoConfiguration()
        {
            Property(v => v.Name)
            .IsRequired()
            .HasMaxLength(255);

            HasRequired(v => v.Genre)
            .WithMany(a => a.Videos)
            .HasForeignKey(v => v.GenreId);





        }
    }
}

