require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar nova filial'
    fill_in 'Nome', with: 'Rent a car'
    fill_in 'CNPJ', with: '75.415.539/0001-00'
    fill_in 'Logradouro', with: 'Vila do Chaves'
    fill_in 'Número', with: '71'
    fill_in 'Complemento', with: 'Dentro do barril'
    fill_in 'Bairro', with: 'México'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Criar filial'

    expect(page).to have_content('Rent a car')
    expect(page).to have_content('75.415.539/0001-00')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('Vila do Chaves, nº 71')
    expect(page).to have_content('Dentro do barril')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end

  scenario 'and must fill all fields' do
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit root_path
    click_on 'Registrar nova filial'
    click_on 'Criar filial'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Logradouro não pode ficar em branco')
    expect(page).to have_content('Número não pode ficar em branco')
    expect(page).to have_content('Bairro não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
  end

  scenario 'and must be admin' do
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    
    expect(page).not_to have_link('Registrar nova filial')
  end

  scenario 'must be admin and uses url' do
    user = create(:user)

    login_as user, scope: :user
    visit new_subsidiary_path
  
    expect(current_path).to eq root_path
  end
end
