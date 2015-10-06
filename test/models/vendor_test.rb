require 'test_helper'
 
class VendorTest < MiniTest::Unit::TestCase
  
  def test_true_is_true
    assert true
  end

  def test_vendor_can_be_built
    assert FactoryGirl.build(:vendor)
  end

  def test_vendor_with_pocs_can_be_built
    assert FactoryGirl.build(:vendor_with_pocs)
  end


  # ==================== #
  #   Validation Tests   #
  # ==================== #

  def test_vendor_can_be_saved
    assert FactoryGirl.create(:vendor)
  end

  def test_vendor_with_pocs_can_be_saved
    assert FactoryGirl.create(:vendor_with_pocs)
  end

  def test_vendor_with_no_name_cannot_be_saved
    assert_raises(Mongoid::Errors::Validations) { FactoryGirl.create(:vendor_no_name) }
  end

  def test_vendors_with_same_name_cannot_be_saved
    FactoryGirl.create(:vendor_repeat_name)
    assert_raises(Mongoid::Errors::Validations) { FactoryGirl.create(:vendor_repeat_name) }
  end
  
  # ====================== #
  #   Model Method Tests   #
  # ====================== #

  # no method tests yet since the vendor model has no methods

end







































