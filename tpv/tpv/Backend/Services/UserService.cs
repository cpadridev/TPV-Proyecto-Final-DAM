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
    public class UserService : GenericService<user>
    {
        private DbContext context;

        public user userLoggedIn { get; set; }

        public UserService(DbContext context) : base(context)
        {
            this.context = context;
        }

        public Boolean Login(String username, String password)
        {
            try
            {
                userLoggedIn = context.Set<user>().Where(u => u.username == username).FirstOrDefault();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.StackTrace);
            }

            if (userLoggedIn == null || !userLoggedIn.username.Equals(username) || !userLoggedIn.password.Equals(password))
            {
                return false;
            }

            return true;
        }
    }
}
