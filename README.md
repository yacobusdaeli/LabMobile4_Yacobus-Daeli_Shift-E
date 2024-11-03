# Tugas Pertemuan 5

### Nama : Yacobus Daeli
### NIM : H1D022024
### Shift : E

# Tampilan Registrasi Page

Sebelum kita melakukan login, user harus melakukan registrasi akun terlebih dahulu. Untuk tampilan registrasi sebagai berikut : 


![Registrasi Page](https://github.com/user-attachments/assets/30e7b06e-6fb9-4c8a-b745-8c1a0449a217)



```javascript
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi Kobus"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _namaTextField(),
                _emailTextField(),
                _passwordTextField(),
                _passwordKonfirmasiTextField(),
                _buttonRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

```

# Alert untuk Halaman Registrasi jika sudah berhasil login


![Registrasi Page berhasil](https://github.com/user-attachments/assets/a7caedfe-f3e9-4abf-885f-e4f38d205af0)


Berikut adalah kode untuk alert :

```javascript
RegistrasiBloc.registrasi(
  nama: _namaTextboxController.text,
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text
).then((value) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => SuccessDialog(
      description: "Registrasi berhasil, silahkan login",
      okClick: () {
        Navigator.pop(context);
      },
    )
  );
});
```

# Tampilan Login Page

![Login Page](https://github.com/user-attachments/assets/2e5a2679-b4a5-415a-9379-8581e77f4729)


Berikut adalah tampilan ketika user melakukan registrasi, seterusnya diarahkan menuju ke halaman login page. berikut adalah kode untuk tampilan login page : 

```javascript
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Kobus'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _emailTextField(),
                _passwordTextField(),
                _buttonLogin(),
                const SizedBox(
                  height: 30,
                ),
                _menuRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }
```

# Alert jika gagal masuk ke halaman login page


![Login page (gagal)](https://github.com/user-attachments/assets/eaa4c8c5-28aa-4fe6-85dc-d5c289a1012a)


Di atas adalah tampilan jika user salah mencantumnkan email/password maka akan muncul alert. Berikut adalah code untuk alert gagal masuk login page : 

```javascript
 showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const WarningDialog(
                  description: "Login gagal, silahkan coba lagi",
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });
  }
```

# Tampilan Produk Page ketika user bisa login

![List Produk Kobus](https://github.com/user-attachments/assets/87339090-7f0d-4bc4-aed9-6d83e562a696)



Di atas adalah ketika pengguna sudah berhasil login langsung di arahkkan ke halamaan utama yaitu halaman produk. Berikut gambar diatas ditampilkan ketika halaman produk kosong, untuk menambahkan ke list produk kita bisa klik button yang ada di kanan atas. berikut kode untuk tampilan halaman produk : 

```javascript

actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProdukForm()));
                },
              ))
        ],

```

# Tampilan Tambah Produk

![Tambah Produk Kobus](https://github.com/user-attachments/assets/4cc74cb6-da06-44f0-9446-31eabc21fac3)


Berikutnya adalah tampilan untuk tambah produk, user diminta untuk mengisi produk form setelah klik button + pada halaman yang sebelumnya. setelah semua datanya terisi user akan klik tombol simpan nantinya datanya akan terisi pada list produk, atau produk page. berikut kode untuk tambah produk :

```javascript

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK Kobus";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }
  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    // createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    createProduk.hargaProduk =
        int.tryParse(_hargaProdukTextboxController.text) ?? 0;

    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }}
```

# Tampilan ketika List Produk (Produk Page) -> ketika user sudah menambahkan data


![List produk Kobus (tambah data)](https://github.com/user-attachments/assets/5162c084-c2d2-47ab-a066-bafdc54fccfc)



Setelah user sudah berhasil tambah data, maka data akan tersimpan ke produk page. berikut adalah code tersebut

```javascript

  body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;
  const ListProduk({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemProduk(
            produk: list![i],
          );
        });
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProdukDetail(
                      produk: produk,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk!),
          subtitle: Text(produk.hargaProduk.toString()),
        ),
      ),
    );
  }
}

```

# Tampilanm Detail Produk


![Detail Produk Kobus](https://github.com/user-attachments/assets/673accbf-4f1f-4ec8-901c-3cdbc94c8a6d)


Ketika user menekan data pada list produk maka akan keluar detail atau rincian pada produk tersebut. code untuk tampilannya adalah sebagai berikut : 

```javascript

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Kobus'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }
```

# Tampilan Edit Produk


![Ubah Produk Kobus](https://github.com/user-attachments/assets/c1aba242-2f44-4a22-84b5-148b74e1cf29)


Ketika user menekan tombol edit / ubah maka produk tersebut bisa diedit sesuai kemauan user. kodenya dibawah ini :

```javascript


// TOMBOL EDIT
 Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProdukForm(
                            produk: widget.produk!,
                          )));
            }),

// FORM
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

// BUTTON UBAH
 Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                //kondisi update produk
                ubah();
              }
```

# Tampilan untuk hapus produk


![hapus data](https://github.com/user-attachments/assets/523d430e-ca8b-42c5-9b37-09d218cba92b)


Berikut adalah untuk tampilan hapus produk, nantinya akan ada alert bahwa apakah yakin akan hapus data untuk menghindari human error, atau ketidaksengajaan penghapusan data. Kode dapat di lihat dari bawah ini :


```javascript

 void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
//tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProdukPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
//tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}


```

# Tampilan untuk Halaman Logout


![Logout Page](https://github.com/user-attachments/assets/6d0dbcd4-2440-4192-8f16-29fec81da338)


Untuk logout atau keluar dari halaman, user harus menekan pada pojok kiri yang terdapat garis tiga. setelah itu user menekan tombol maka akan kembali halaman login. kode sbg berikut : 

```javascript

children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],

```










