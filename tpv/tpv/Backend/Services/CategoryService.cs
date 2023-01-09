using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tpv.Backend.Models;
using tpv.Backend.Services.Base;

namespace tpv.Backend.Services
{
    public class CategoryService : GenericService<category>
    {
        public CategoryService(DbContext context) : base(context)
        {
        }
    }
}
