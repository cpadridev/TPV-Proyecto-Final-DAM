using MahApps.Metro.Controls;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using System.Windows.Threading;
using tpv.Backend.Models;
using tpv.Backend.Services;
using tpv.Frontend.Dialogs;
using tpv.MVVM;
using Button = System.Windows.Controls.Button;
using Image = System.Windows.Controls.Image;

namespace tpv
{
    /// <summary>
    /// Lógica de interacción para MainWindow.xaml
    /// </summary>
    public partial class MainWindow : MetroWindow
    {
        private user userLoggedIn;
        private UserService userServ;
        private CategoryService catServ;
        private ProductService prodServ;
        private List<category> categoriesList;
        private List<product> productsList;
        private MVSaleDetails mvSaleDetails;

        public MainWindow(tpvEntities tpvEntities, user user)
        {
            InitializeComponent();
            userLoggedIn = user;
            catServ = new CategoryService(tpvEntities);
            prodServ = new ProductService(tpvEntities);
            userServ = new UserService(tpvEntities);
            mvSaleDetails = new MVSaleDetails();
            DataContext = mvSaleDetails;
            this.AddHandler(Validation.ErrorEvent, new RoutedEventHandler(mvSaleDetails.OnErrorEvent));
            mvSaleDetails.btnSave = btnContinue;
            txtUsername.Text = userLoggedIn.username;
            CheckPermissions();
            CreateNumbers();
            ShowCategories();
        }

        private void CheckPermissions()
        {
            List<permission> permissionsList = userServ.GetPermissionsByUser(userLoggedIn.id_user);

            int counter = 0;

            foreach (permission p in permissionsList)
            {
                switch (p.id_permission)
                {
                    case 2:
                        mniReturnSales.Visibility = Visibility.Visible;
                        counter++;
                        break;
                    case 3:
                        btnAddProduct.Visibility = Visibility.Visible;
                        break;
                    case 4:
                        btnModifyProduct.Visibility = Visibility.Visible;
                        btnDeleteProduct.Visibility = Visibility.Visible;
                        break;
                    case 5:
                        mniAdvertisingCampaings.Visibility = Visibility.Visible;
                        counter++;
                        break;
                    case 6:
                        mniManageUsers.Visibility = Visibility.Visible;
                        counter++;
                        break;
                    case 7:
                        mniEditPermissions.Visibility = Visibility.Visible;
                        counter++;
                        break;
                    case 8:
                        mniManagePasswords.Visibility = Visibility.Visible;
                        counter++;
                        break;
                    case 9:
                        mniEditRoles.Visibility = Visibility.Visible;
                        counter++;
                        break;
                }
            }

            if (counter != 0)
            {
                mniAdminSettings.Visibility = Visibility.Visible;
            }
        }

        private void CreateNumbers()
        {
            for (int i = 0; i < 9; i++)
            {
                Button btnNumber = new Button
                {
                    Content = i + 1,
                    Height = 80,
                    Width = 80,
                    Margin = new Thickness(2.5)
                };

                btnNumber.Click += btnNumber_Click;

                Grid.SetColumn(btnNumber, i % 3);
                Grid.SetRow(btnNumber, i / 3);

                gridNumPad.Children.Add(btnNumber);
            }
        }

        private void ShowCategories()
        {
            gridCategories.Children.Clear();
            categoriesList = catServ.GetAll().ToList();
            CreateRows(categoriesList.Count, gridCategories);

            for (int i = 0; i < categoriesList.Count; i++)
            {


                Button btnCategory = new Button
                {
                    Content = categoriesList[i].name,
                    Height = 70,
                    Margin = new Thickness(7.5)
                };

                int idCategory = categoriesList[i].id_category;

                btnCategory.Click += (s, e) =>
                {
                    ShowProducts(idCategory);
                };

                Grid.SetRow(btnCategory, i);

                gridCategories.Children.Add(btnCategory);
            }
        }

        private void ShowProducts(int idCategory)
        {
            wrapPanelProducts.Children.Clear();
            productsList = prodServ.GetProductsByCategory(idCategory);

            for (int i = 0; i < productsList.Count; i++)
            {
                Grid grid = new Grid();
                CreateRows(3, grid);

                TextBlock tx = new TextBlock
                {
                    Text = productsList[i].name,
                    HorizontalAlignment = HorizontalAlignment.Center,
                    VerticalAlignment = VerticalAlignment.Center,
                    Margin = new Thickness(0, 10, 0, 0)
                };

                Grid.SetRow(tx, 0);
                grid.Children.Add(tx);

                if (productsList[i].image != null)
                {
                    Image img = new Image
                    {
                        Source = System.Windows.Interop.Imaging.CreateBitmapSourceFromHBitmap(new Bitmap((Bitmap)new ImageConverter().ConvertFrom(productsList[i].image)).GetHbitmap(), IntPtr.Zero, Int32Rect.Empty, BitmapSizeOptions.FromEmptyOptions()),
                        Height = 164,
                        Width = 164
                    };

                    Grid.SetRow(img, 1);
                    grid.Children.Add(img);
                }

                TextBlock tx2 = new TextBlock
                {
                    Text = "Stock: " + productsList[i].quantity.ToString(),
                    HorizontalAlignment = HorizontalAlignment.Center,
                    VerticalAlignment = VerticalAlignment.Center,
                    Margin = new Thickness(0, 10, 0, 10)
                };

                Grid.SetRow(tx2, 2);
                grid.Children.Add(tx2);

                Button btnProduct = new Button
                {
                    Content = grid,
                    Height = 244,
                    Width = 244,
                    Margin = new Thickness(10),
                    BorderThickness = new Thickness(25)
                };

                product product = productsList[i];

                btnProduct.Click += (s, e) =>
                {
                    sale_details saleDetails = new sale_details();

                    saleDetails.product = product;
                    saleDetails.product.price = Math.Round(product.price, 2);
                    saleDetails.quantity = 1;
                    saleDetails.price = product.price;

                    if (product.offer != null && product.offer.discount != null)
                    {
                        saleDetails.price = Math.Round(saleDetails.price - (double)(product.price * (product.offer.discount / 100)), 2);
                    }

                    if (product.iva != null)
                    {
                        saleDetails.price = Math.Round(saleDetails.price + (double)(saleDetails.price * product.iva / 100), 2);
                    }

                    if (!mvSaleDetails.newSaleDetails.Any(d => d.product == saleDetails.product))
                    {
                        mvSaleDetails.newSaleDetails.Add(saleDetails);

                        if (!string.IsNullOrEmpty(txbTotal.Text))
                        {
                            txbTotal.Text = Math.Round(double.Parse(txbTotal.Text.Remove(txbTotal.Text.Length - 1)) + saleDetails.price, 2).ToString() + "€";
                        }
                        else
                        {
                            txbTotal.Text = saleDetails.price + "€";
                        }

                        dataGridSaleDetails.Items.Refresh();
                        dataGridSaleDetails.SelectedItem = saleDetails;
                        dataGridSaleDetails.Focus();
                    }
                };

                int quantity = productsList[i].quantity;

                if (quantity == 0)
                {
                    btnProduct.IsEnabled = false;
                }

                wrapPanelProducts.Children.Add(btnProduct);
            }
        }

        private void CreateRows(int numRows, Grid panel)
        {
            for (int i = 0; i < numRows; i++)
            {
                RowDefinition row = new RowDefinition();
                row.Height = GridLength.Auto;
                panel.RowDefinitions.Add(row);
            }
        }

        private void btnDeleteList_Click(object sender, RoutedEventArgs e)
        {
            mvSaleDetails.newSaleDetails.Clear();

            dataGridSaleDetails.Items.Refresh();

            txbTotal.Text = "0€";
            txbNameProduct.Text = string.Empty;
            txbQuantityProduct.Text = string.Empty;
            txbPriceProduct.Text = string.Empty;
            txbIvaProduct.Text = string.Empty;
            txbOfferProduct.Text = string.Empty;
            txbTotalProduct.Text = string.Empty;
        }

        private void btnNumber_Click(object sender, RoutedEventArgs e)
        {
            sale_details saleDetails = (sale_details)dataGridSaleDetails.SelectedItem;

            if (saleDetails != null)
            {
                Button btn = (Button)sender;

                if (txbQuantityProduct.Text != "0")
                {
                    txbQuantityProduct.Text += btn.Content.ToString();
                }
                else
                {
                    txbQuantityProduct.Text = btn.Content.ToString();
                }
            }
        }

        private void btnClear_Click(object sender, RoutedEventArgs e)
        {
            if ((sale_details)dataGridSaleDetails.SelectedItem != null)
            {
                txbQuantityProduct.Text = "0";
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            if ((sale_details)dataGridSaleDetails.SelectedItem != null && txbQuantityProduct.Text.Length > 1)
            {
                txbQuantityProduct.Text = txbQuantityProduct.Text.Remove(txbQuantityProduct.Text.Length - 1);
            }
            else
            {
                txbQuantityProduct.Text = "0";
            }
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            if ((sale_details)dataGridSaleDetails.SelectedItem != null)
            {
                txbQuantityProduct.Text = (int.Parse(txbQuantityProduct.Text) + 1).ToString();
            }
        }

        private void btnRemove_Click(object sender, RoutedEventArgs e)
        {
            if ((sale_details)dataGridSaleDetails.SelectedItem != null && int.Parse(txbQuantityProduct.Text) > 0)
            {
                txbQuantityProduct.Text = (int.Parse(txbQuantityProduct.Text) - 1).ToString();
            }
        }

        private void btnAccept_Click(object sender, RoutedEventArgs e)
        {
            sale_details saleDetails = (sale_details)dataGridSaleDetails.SelectedItem;

            if (saleDetails != null && saleDetails.quantity != int.Parse(txbQuantityProduct.Text))
            {
                double pastPrice = saleDetails.price;

                if (txbQuantityProduct.Text == "0")
                {
                    txbQuantityProduct.Text = "1";
                }

                saleDetails.quantity = int.Parse(txbQuantityProduct.Text);

                if (int.Parse(txbQuantityProduct.Text) > saleDetails.product.quantity)
                {
                    saleDetails.quantity = saleDetails.product.quantity;
                }

                txbQuantityProduct.Text = saleDetails.quantity.ToString();

                saleDetails.price = saleDetails.product.price;

                if (saleDetails.product.offer != null && saleDetails.product.offer.discount != null)
                {
                    saleDetails.price = Math.Round(saleDetails.price - (double)(saleDetails.product.price * (saleDetails.product.offer.discount / 100)), 2);
                }

                if (saleDetails.product.iva != null)
                {
                    saleDetails.price = Math.Round(saleDetails.price + (double)(saleDetails.price * saleDetails.product.iva / 100), 2);
                }

                saleDetails.price = Math.Round(saleDetails.price * saleDetails.quantity, 2);

                dataGridSaleDetails.Items.Refresh();
                dataGridSaleDetails.SelectedItem = saleDetails;

                txbTotalProduct.Text = saleDetails.price.ToString() + "€";
                txbTotal.Text = Math.Round(double.Parse(txbTotal.Text.Remove(txbTotal.Text.Length - 1)) - pastPrice + saleDetails.price, 2).ToString() + "€";
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            sale_details saleDetails = (sale_details)dataGridSaleDetails.SelectedItem;

            if (saleDetails != null)
            {
                mvSaleDetails.newSaleDetails.Remove(mvSaleDetails.newSaleDetails.Single(s => s == saleDetails));
                dataGridSaleDetails.Items.Refresh();
                sale_details lastitem = mvSaleDetails.newSaleDetails.LastOrDefault();

                if (lastitem != null)
                {
                    dataGridSaleDetails.SelectedItem = lastitem;
                    dataGridSaleDetails.ScrollIntoView(lastitem);
                    dataGridSaleDetails.Focus();
                    txbTotal.Text = Math.Round(double.Parse(txbTotal.Text.Remove(txbTotal.Text.Length - 1)) - saleDetails.price, 2).ToString() + "€";

                    txbNameProduct.Text = lastitem.product.name;
                    txbQuantityProduct.Text = lastitem.quantity.ToString();
                    txbPriceProduct.Text = lastitem.product.price.ToString() + "€";
                    if (lastitem.product.iva != null )
                    {
                        txbIvaProduct.Text = lastitem.product.iva.ToString() + "%";
                    }
                    if (lastitem.product.offer != null && lastitem.product.offer.discount != null)
                    {
                        txbOfferProduct.Text = lastitem.product.offer.discount.ToString() + "%";
                    }
                    txbTotalProduct.Text = lastitem.price + "€";
                }
                else
                {
                    btnDeleteList.IsEnabled = false;
                    txbNameProduct.Text = string.Empty;
                    txbQuantityProduct.Text = string.Empty;
                    txbPriceProduct.Text = string.Empty;
                    txbTotalProduct.Text = string.Empty;
                    txbIvaProduct.Text = string.Empty;
                    txbOfferProduct.Text = string.Empty;
                    txbTotal.Text = "0€";
                }
            }
        }

        private void dataGridSaleDetails_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            btnContinue.IsEnabled = false;
            sale_details saleDetails = (sale_details)dataGridSaleDetails.SelectedItem;

            if (saleDetails != null)
            {
                btnDeleteList.IsEnabled = true;
                txbNameProduct.Text = saleDetails.product.name;
                txbQuantityProduct.Text = saleDetails.quantity.ToString();
                txbPriceProduct.Text = saleDetails.product.price + "€";
                txbIvaProduct.Text = "0%";
                txbOfferProduct.Text = string.Empty;
                if (saleDetails.product.iva != null)
                {
                    txbIvaProduct.Text = saleDetails.product.iva.ToString() + "%";
                }
                if (saleDetails.product.offer != null && saleDetails.product.offer.discount != null)
                {
                    txbOfferProduct.Text = saleDetails.product.offer.discount.ToString() + "%";
                }
                txbTotalProduct.Text = saleDetails.price + "€";
                if (userServ.GetPermissionsByUser(userLoggedIn.id_user).Find(r => r.id_permission == 1) != null)
                {
                    btnContinue.IsEnabled = true;
                }
            }
        }

        private void btnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void btnModifyProduct_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void btnDeleteProduct_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void btnContinue_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniLogout_Click(object sender, RoutedEventArgs e)
        {
            LoginDialog dialog = new LoginDialog();
            dialog.Show();
            this.Close();
        }

        private void mniEditProfile_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniViewProfile_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniReports_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniGraphs_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniReturnSales_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniAdvertisingCampaings_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniManageUsers_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniEditPermissions_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniManagePasswords_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void mniEditRoles_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }
    }
}
