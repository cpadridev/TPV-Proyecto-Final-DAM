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
    
    public partial class sale
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public sale()
        {
            this.sale_details = new HashSet<sale_details>();
        }
    
        public int id_sale { get; set; }
        public System.DateTime date { get; set; }
        public string payment { get; set; }
        public double total { get; set; }
        public byte[] ticket { get; set; }
        public int id_customer { get; set; }
        public int id_user { get; set; }
    
        public virtual customer customer { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<sale_details> sale_details { get; set; }
        public virtual user user { get; set; }
    }
}
