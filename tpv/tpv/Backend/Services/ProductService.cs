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
    public class ProductService : GenericService<product>
    {
        private DbContext context;

        public user userLoggedIn { get; set; }

        public ProductService(DbContext context) : base(context)
        {
            this.context = context;
        }

        public List<product> GetProductsByCategory(int idCategory)
        {
            return context.Set<product>().Where(p => p.id_category == idCategory).ToList();
        }
    }
}
