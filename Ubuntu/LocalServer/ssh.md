# SSH cheat sheet

## Steup ssh key to github/gitlab
3. SSH:
3.1 В cmd:
ssh-keygen -t ed25519 -C "<comment>"

3.2
Жмём enter когда видим:
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/user/.ssh/id_ed25519):

3.3
Вводим (дважды) пароль который ставил на ключ, когда видим:
Enter passphrase (empty for no passphrase):
Enter same passphrase again:

3.4
Запускаем Git Bash и копируем ключ:
cat ~/.ssh/id_ed25519.pub | clip

3.5
И добавляем его на страничке:
https://gitlab.rtl-consulting.ru/-/profile/keys

3.6
Выполняем команду в GitBash в нужной директории:
git clone git@gitlab.rtl-consulting.ru:rtl-rnd-group/rtl-platform-front.git

