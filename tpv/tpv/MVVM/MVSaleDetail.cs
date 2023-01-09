using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using tpv.Backend.Models;
using tpv.MVVM.Base;

namespace tpv.MVVM
{
    internal class MVSaleDetail : MVBaseCRUD<sales_details>
    {
        private List<sales_details> saleDetailList;

        public MVSaleDetail()
        {
            saleDetailList = new List<sales_details>();
        }

        public List<sales_details> newSaleDetail
        {
            get
            {
                return saleDetailList;
            }
            set
            {
                saleDetailList = value;
                NotifyPropertyChanged(nameof(saleDetailList));
            }
        }
    }
}
