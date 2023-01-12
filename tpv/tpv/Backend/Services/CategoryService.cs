using System.Data.Entity;
using tpv.Backend.Models;
using tpv.Backend.Services.Base;

namespace tpv.Backend.Services
{
    public class CategoryService : GenericService<category>
    {
        private DbContext context;

        public CategoryService(DbContext context) : base(context)
        {
            this.context = context;
        }
    }
}
