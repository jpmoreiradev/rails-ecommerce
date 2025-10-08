# Usuário de teste
User.create!(email: "teste@teste.com", password: "12345678")

# Produtos de teste
10.times do |i|
  Product.create!(
    title: "Camisa Azul",
    description: "Camisa estilosa",
    price_cents: 4500,
    stock: 20,
    slug: "camisa-azul",
    image_url: "https://picsum.photos/200/300"
  )
end
