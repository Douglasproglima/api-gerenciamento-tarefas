require 'rails_helper'

RSpec.describe User, type: :model do
  # subject { FactoryGirl.build(:user) }
  
  # before { @user = FactoryGirl.build(:user) }

  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:name)}
  # it { expect(@user).to respond_to(:password)}
  # it { expect(@user).to respond_to(:password_confirmation)}
  # it { expect(@user).to be_valid }

  # subject = User.:name

  # it { expect(subject).to respond_to(:email) }
  # it { expect(subject).to respond_to(:password)}
  # it { expect(subject).to respond_to(:password_confirmation)}
  # it { expect(subject).to be_valid }

  # it { is_expected.to respond_to(:email)}
  # it { is_expected.to respond_to(:password)}
  # it { is_expected.to respond_to(:password_confirmation)}
  # it { is_expected.to be_valid }

  # it { expect(user).to respond_to(:password) }
  # it { expect(user).to respond_to(:password_confirmation) }
  # it { expect(user).to be_valid }

  let(:user){ build(:user) }
  #it { expect(user).to respond_to(:email) }

  #Teste quando o usuário for vázio
  # context 'when name is blank' do
  #   before { user.name = ' ' }

  #   it { expect(user).not_to be_valid }
  # end

  #Teste quando o usuário for null
  # context 'when name is nill' do
  #   before { user.name = ' ' }

  #   it { expect(user).not_to be_valid }
  # end

############ Como usar o shoulda-matchers ############
  #it { expect(user).to validate_presence_of(:name) }
  # it {is_expected.to validate_numericality_of(:age) }
  
  it {is_expected.to validate_presence_of(:email) }
  it {is_expected.to validate_uniqueness_of(:email).case_insensitive } #Testa se o e-mail é unico e case insensitive
  it {is_expected.to validate_confirmation_of(:password) } #Testa se a senha é igual ao informado no password_confirmation
  it {is_expected.to allow_value('douglasproglima@gmail.com').for(:email) }
end