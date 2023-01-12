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
        private int idProductPressed;

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
            idProductPressed = 0;
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
                if (productsList[i].quantity != 0)
                {
                    Button btnProduct = new Button
                    {
                        Content = productsList[i].name,
                        Height = 175,
                        Width = 175,
                        Margin = new Thickness(10)
                    };

                    if (productsList[i].image != null)
                    {
                        StackPanel stackPanel = new StackPanel
                        {
                            Orientation = System.Windows.Controls.Orientation.Vertical,
                            Children =
                        {
                            new TextBlock
                            {
                                Text = productsList[i].name,
                                Margin = new Thickness(0, 0, 0, 10),
                                HorizontalAlignment = HorizontalAlignment.Center,
                            },
                            new Image
                            {
                                Source = System.Windows.Interop.Imaging.CreateBitmapSourceFromHBitmap(new Bitmap((Bitmap)new ImageConverter().ConvertFrom(productsList[i].image)).GetHbitmap(), IntPtr.Zero, Int32Rect.Empty, BitmapSizeOptions.FromEmptyOptions())
                            }
                        }
                        };

                        btnProduct.Content = stackPanel;
                    }

                    product product = productsList[i];

                    btnProduct.Click += (s, e) =>
                    {
                        sale_details saleDetail = new sale_details();

                        saleDetail.product = product;
                        saleDetail.quantity = 1;
                        saleDetail.price = product.price;

                        if (product.offer != null)
                        {
                            saleDetail.price = product.price - (double)(product.price * (product.offer.discount / 100));
                        }

                        if (!mvSaleDetails.newSaleDetails.Any(d => d.product == saleDetail.product))
                        {
                            mvSaleDetails.newSaleDetails.Add(saleDetail);

                            if (!string.IsNullOrEmpty(txbTotal.Text))
                            {
                                txbTotal.Text = ((double.Parse(txbTotal.Text)) + saleDetail.price).ToString();
                            }
                            else
                            {
                                txbTotal.Text = saleDetail.price.ToString();
                            }

                            dataGridSaleDetails.Items.Refresh();
                            dataGridSaleDetails.SelectedItem = saleDetail;
                            dataGridSaleDetails.Focus();
                        }
                    };

                    btnProduct.PreviewMouseDown += async (s, e) =>
                    {
                        if (await TouchHold(btnProduct, TimeSpan.FromSeconds(1.5)))
                        {
                            txtProductSelected.Text = product.name;
                            idProductPressed = product.id_product;
                        }
                    };

                    wrapPanelProducts.Children.Add(btnProduct);
                }
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

        private void btnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            // Dialog
        }

        private void btnModifyProduct_Click(object sender, RoutedEventArgs e)
        {
            if (idProductPressed != 0)
            {
                product product = prodServ.FindByID(idProductPressed);
            }
        }

        private void btnDeleteProduct_Click(object sender, RoutedEventArgs e)
        {
            if (idProductPressed != 0)
            {
                product product = prodServ.FindByID(idProductPressed);
            }
        }

        private void btnDeleteList_Click(object sender, RoutedEventArgs e)
        {
            mvSaleDetails.newSaleDetails.Clear();

            dataGridSaleDetails.Items.Refresh();

            txbTotal.Text = string.Empty;
            txbNameProduct.Text = string.Empty;
            txbQuantityProduct.Text = string.Empty;
            txbPriceProduct.Text = string.Empty;
            txbOfferProduct.Text = string.Empty;
            txbTotalProduct.Text = string.Empty;
        }

        private void btnContinue_Click(object sender, RoutedEventArgs e)
        {
            if (mvSaleDetails.newSaleDetails.Count != 0)
            {
                /*MakePurchaseDialogMVVM dialog = new MakePurchaseDialogMVVM(tpvEnt, mvSaleDetails.newSaleDetails, userLoggedIn, double.Parse(txbTotal.Text));
                dialog.Show();*/
            }
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
                txbQuantityProduct.Text = (double.Parse(txbQuantityProduct.Text) + 1).ToString();
            }
        }

        private void btnRemove_Click(object sender, RoutedEventArgs e)
        {
            if ((sale_details)dataGridSaleDetails.SelectedItem != null && double.Parse(txbQuantityProduct.Text) > 0)
            {
                txbQuantityProduct.Text = (double.Parse(txbQuantityProduct.Text) - 1).ToString();
            }
        }

        private void btnAccept_Click(object sender, RoutedEventArgs e)
        {
            sale_details saleDetails = (sale_details)dataGridSaleDetails.SelectedItem;

            if (saleDetails != null && saleDetails.quantity != double.Parse(txbQuantityProduct.Text))
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
                    txbQuantityProduct.Text = saleDetails.product.quantity.ToString();
                }

                saleDetails.price = saleDetails.quantity * saleDetails.product.price;

                sale_details sale = mvSaleDetails.newSaleDetails.FirstOrDefault(s => s == saleDetails);

                sale.quantity = int.Parse(txbQuantityProduct.Text);

                if (int.Parse(txbQuantityProduct.Text) > saleDetails.product.quantity)
                {
                    sale.quantity = saleDetails.product.quantity;
                }

                dataGridSaleDetails.Items.Refresh();
                dataGridSaleDetails.SelectedItem = saleDetails;

                txbTotalProduct.Text = saleDetails.price.ToString();
                txbTotal.Text = (double.Parse(txbTotal.Text) - pastPrice + (saleDetails.quantity * saleDetails.product.price)).ToString();
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
                    txbTotal.Text = (double.Parse(txbTotal.Text) - (lastitem.quantity * lastitem.product.price)).ToString();

                    txbNameProduct.Text = lastitem.product.name;
                    txbQuantityProduct.Text = lastitem.quantity.ToString();
                    txbPriceProduct.Text = lastitem.product.price.ToString();
                    if (lastitem.product.offer != null)
                    {
                        txbOfferProduct.Text = lastitem.product.offer.discount.ToString();
                    }
                    txbTotalProduct.Text = (lastitem.quantity * lastitem.product.price).ToString();
                }
                else
                {
                    txbNameProduct.Text = string.Empty;
                    txbQuantityProduct.Text = string.Empty;
                    txbPriceProduct.Text = string.Empty;
                    txbTotalProduct.Text = string.Empty;
                    txbOfferProduct.Text = string.Empty;
                    txbTotal.Text = string.Empty;
                }
            }
        }

        private void dataGridSaleDetails_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            btnContinue.IsEnabled = false;
            sale_details saleDetails = (sale_details)dataGridSaleDetails.SelectedItem;

            if (saleDetails != null)
            {
                txbNameProduct.Text = saleDetails.product.name;
                txbQuantityProduct.Text = saleDetails.quantity.ToString();
                txbPriceProduct.Text = saleDetails.product.price.ToString();
                txbOfferProduct.Text = string.Empty;
                if (saleDetails.product.offer != null)
                {
                    txbOfferProduct.Text = saleDetails.product.offer.discount.ToString();
                }
                txbTotalProduct.Text = (saleDetails.quantity * saleDetails.product.price).ToString();
                if (userServ.GetPermissionsByUser(userLoggedIn.id_user).Find(r => r.id_permission == 1) != null)
                {
                    btnContinue.IsEnabled = true;
                }
            }
        }

        private Task<bool> TouchHold(FrameworkElement element, TimeSpan duration)
        {
            DispatcherTimer timer = new DispatcherTimer();
            TaskCompletionSource<bool> task = new TaskCompletionSource<bool>();
            timer.Interval = duration;

            MouseButtonEventHandler touchUpHandler = delegate
            {
                timer.Stop();
                if (task.Task.Status == TaskStatus.Running)
                {
                    task.SetResult(false);
                }
            };

            element.PreviewMouseUp += touchUpHandler;

            timer.Tick += delegate
            {
                element.PreviewMouseUp -= touchUpHandler;
                timer.Stop();
                task.SetResult(true);
            };

            timer.Start();
            return task.Task;
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
