Pour ajouter un nouveau serveur à l'inventaire :

```bash
sh -c "$(curl -sSL https://raw.githubusercontent.com/PAPAMICA/rundeck-add/main/runadopt.sh)" 
```

Pour ajouter en changeant le nom du serveur au passage :

```bash
curl https://raw.githubusercontent.com/PAPAMICA/rundeck-add/main/runadopt.sh | bash -s <NAME>
```
