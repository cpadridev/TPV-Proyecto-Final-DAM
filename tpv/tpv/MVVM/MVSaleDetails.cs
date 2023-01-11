using System.Collections.Generic;
using tpv.Backend.Models;
using tpv.MVVM.Base;

namespace tpv.MVVM
{
    internal class MVSaleDetails : MVBaseCRUD<sale_details>
    {
        private List<sale_details> saleDetailsList;

        public MVSaleDetails()
        {
            saleDetailsList = new List<sale_details>();
        }

        public List<sale_details> newSaleDetails
        {
            get
            {
                return saleDetailsList;
            }
            set
            {
                saleDetailsList = value;
                NotifyPropertyChanged(nameof(saleDetailsList));
            }
        }
    }
}
