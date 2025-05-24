# 📍 Pontos de Interesse

Este é um aplicativo Flutter simples que permite ao usuário:

- Ver sua **localização atual**.
- **Cadastrar manualmente** pontos de interesse com nome, descrição, latitude e longitude.
- Ver uma **lista de pontos cadastrados** com a **distância em metros** em relação à sua localização atual.

---

## 🚀 Funcionalidades

### ✅ Localização Atual
- Ao abrir o app, ele solicita permissão para acessar a localização.
- A localização é obtida via `Geolocator.getCurrentPosition()` e exibida com latitude e longitude na tela inicial.
- Um botão "Atualizar Localização" permite obter novamente a posição atual.

### ✅ Cadastro de Pontos
- Através do botão flutuante ➕ na tela inicial, o usuário pode adicionar um novo ponto com:
  - Nome
  - Descrição
  - Latitude
  - Longitude

### ✅ Listagem com Distância
- O app exibe uma lista de todos os pontos cadastrados.
- Para cada ponto, é mostrado:
  - O nome
  - A descrição
  - A **distância até a localização atual do usuário**

---

## 📏 Como é feito o cálculo da distância?

O cálculo da distância entre o ponto atual e os pontos cadastrados é feito utilizando a função:

```dart
Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
```

Essa função retorna a **distância em metros** entre duas coordenadas geográficas (latitude e longitude), aplicando a fórmula de **Haversine**, que considera a curvatura da Terra.

No app, é feito assim:

```dart
final distance = Geolocator.distanceBetween(
  _currentPosition!.latitude,
  _currentPosition!.longitude,
  poi.latitude,
  poi.longitude,
);
```

A distância é então exibida com duas casas decimais no `ListTile` de cada ponto.

---

## 🧱 Estrutura

- `HomeScreen`: tela principal onde é exibida a lista dos pontos e a distância até eles.
- `AddPOIScreen`: tela para adicionar um novo ponto.
- `POIProvider`: gerencia os pontos cadastrados via `Provider`.
- `POIModel`: define a estrutura dos dados de um ponto de interesse.

---

## 📱 Requisitos

- Permissão de localização (GPS).
- Conexão USB para testes em dispositivos físicos (para Android).

---

## 🛠️ Tecnologias usadas

- [Flutter](https://flutter.dev)
- [Provider](https://pub.dev/packages/provider) – gerenciamento de estado
- [Geolocator](https://pub.dev/packages/geolocator) – para obter localização e calcular distâncias

