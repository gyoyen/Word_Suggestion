# Word Suggestion

Proje Amacı: İngilizce öğrenmek isteyen kullanıcılara günlük olarak kelime önderileri yapılarak kişinin dil öğrenimine katkı sağlanması.

## Proje Planlaması

- Kullanıcı giriş - çıkış:</br></br>
Kayıt ve giriş işlemleri Firebase Authentication ile yapılacak.</br>
Kullanıcı giriş çıkışı bir Controller sınıfı tarafından kontrol edilip gerekli sayfaya yönlendirme sağlanacak.</br>
Ayrıca "Parolamı unuttum" seçeneği ile kullanıcının kayıtlı email adresine parola sıfırlama bağlantısı gönderilecek.</br></br>

- Kullanıcı kayıt:</br></br>
"Login" ekranında kullanıcının yeni kayıt oluşturabilmesi için bir seçenek olacaktır.</br>
Bu seçenekle birlikte kayıt sayfasına yönlendirilen kullanıcı zorunlu ve zorunlu olmayan bilgileriyle birlikte yeni bir üyelik oluşturabilecek.</br>
Kayıt işlemi tamamlandığında Authentication tarafında yeni bir kayıt oluşturulacak.</br>
Bu işlemin akabinde Realtime Database kısmında Authentication tarafından alınan "User Id" ile kullanıcının diğer bilgilerini içeren bir kayıt eklenecek.</br></br>

- Profil düzenleme:</br></br>
Kullanıcı giriş yaptığında kendi bilgileri düzenleyebileceği bir sayfa olacak. Burada kullanıcı değiştirilebilir olan bilgileri üzerinde düzenleme yapabilecek.</br></br>

- Kelime önerisi:</br></br>
Kelime öğrenme sayfasında kullanıcıya 10 adet kelime önerisi yapılacak. Bu kelimeler ve anlamları uygun görülen bir Dictionari Api'ı yardımıyla getirilecek.</br>
Her bir kelime ile birlikte kullanıcıya "Öğrendim" ve "Daha sonra hatırlat" seçenekleri sunulacak.</br>
Kullanıcı kelimeyi öğrendiyse Realtime Database tarafında "User Id"yi referans alan bir tabloda tutulacak.</br>
Yeni kelime önerisi yapılacağı zaman bu tablodaki kelimeler kontrol edilecek. Eğer kelime öğrenildiyse kullanıcıya başka bir kelime önderisinde bulunulacak.</br></br>

- Öğrenilen kelimeler:</br></br>
Kullanıcı kendisine ait öğrenilen kelimeleri görebilecek. Eğer isterse bu kelimeleri tekrar "Öğrenilmedi" olarak işaretleyebilecek.</br></br>