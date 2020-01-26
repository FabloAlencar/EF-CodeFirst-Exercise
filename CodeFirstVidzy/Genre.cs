using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeFirstVidzy
{
    public class Genre
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public ICollection<Video> Videos { get; set; }

        public Genre()
        {
            Videos = new Collection<Video>();
        }

    }

}
