//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace tpv.Backend.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public product()
        {
            this.sale_details = new HashSet<sale_details>();
        }
    
        public int id_product { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public byte[] image { get; set; }
        public double price { get; set; }
        public Nullable<int> iva { get; set; }
        public int quantity { get; set; }
        public int id_category { get; set; }
        public int id_location { get; set; }
        public Nullable<int> id_offer { get; set; }
    
        public virtual category category { get; set; }
        public virtual location location { get; set; }
        public virtual offer offer { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<sale_details> sale_details { get; set; }
    }
}
