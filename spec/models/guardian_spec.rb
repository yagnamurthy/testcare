require 'spec_helper'
require_dependency 'permission_error'

describe Guardian do

  context '#authorized?' do 
    it 'returns false when guest' do 
      @guardian = Guardian.new()
      @guardian.authorized?.should eq(false)
    end

    it 'returns true when is an authenticated user' do 
      @guardian = Guardian.new(Caregiver.new)
      @guardian.authorized?.should eq(true)
    end
  end

  context '#ensure_caregiver!' do 
    it 'raises expection when current_user isnt a caregiver' do 
      @guardian = Guardian.new()
      expect { @guardian.ensure_caregiver! }.to raise_error(PermissionError)
    end

    it 'returns true when current_user is a caregiver' do 
      @guardian = Guardian.new(Caregiver.new)
      @guardian.ensure_caregiver!.should eq(true)
    end
  end

  context '#ensure_family!' do 
    it 'raises expection when current_user isnt a family' do 
      @guardian = Guardian.new()
      expect { @guardian.ensure_family! }.to raise_error(PermissionError)
    end

    it 'returns true when current_user is a family' do 
      @guardian = Guardian.new(User.new)
      @guardian.ensure_family!.should eq(true)
    end
  end

  context '#ensure_admin!' do 
    it 'raises expection when current_user isnt an admin' do 
      @guardian = Guardian.new()
      expect { @guardian.ensure_admin! }.to raise_error(PermissionError)
    end

    it 'returns true when current_user is an admin' do 
      @guardian = Guardian.new(Admin.new)
      @guardian.ensure_admin!.should eq(true)
    end
  end

  context '#ensure_authorized!' do 
    it 'raises exception when current_user is a guest' do 
      @guardian = Guardian.new()
      expect { @guardian.ensure_authorized! }.to raise_error(PermissionError)
    end

    it 'returns true when current_user is authorized' do 
      guardian = Guardian.new(Caregiver.new)
      guardian.ensure_authorized!.should eq(true)
    end
  end

  context '#can?' do 
    it 'throws an exception when klass is nil' do 
      @guardian = Guardian.new(Caregiver.new)
      expect { @guardian.can?(:view, nil)  }.to raise_error(ArgumentError)
    end

    it 'throws an exception when action is nil' do 
      @guardian = Guardian.new(Caregiver.new)
      expect { @guardian.can?(nil, Offer.new) }.to raise_error(ArgumentError)
    end
  end

  context '#can_see_journal?' do 
    it 'throws exception when the user is a guest' do 
      @guardian = Guardian.new()
      expect { @guardian.can_see_journal? }.to raise_error(PermissionError)
    end

    it 'throws exception when user isnt assoicated with contract' do 
      caregiver = double(Caregiver)
      caregiver.stub(:contract_ids?).and_return([1])

      @guardian = Guardian.new(caregiver)
      expect { @guardian.can_see_journal? }.to raise_error(PermissionError)
    end

    # it 'returns true when user is owner of the contract' do 
    #   @guardian = Guardian.new(User.new)
    #   @guardian.can_see_journal?.should eq(true)
    # end

    # it 'returns true when the user is assoicated with the contact' do 
    #   @guardian = Guardian.new(Caregiver.new)
    #   @guardian.can_see_journal?.should eq(true)
    # end

    # it 'returns true when the user is an admin' do 
    #   @guardian = Guardian.new(Admin.new)
    #   @guardian.can_see_journal?.should eq(true)
    # end
  end

  # context '#can_edit_journal?' do 
  #   it 'throws exception when the user is a guest' do 
  #     @guardian = Guardian.new()
  #     expect { @guardian.can_edit_journal? }.to raise_error(PermissionError)
  #   end

  #   it 'throws exception when the user isnt the owner of the contract' do 
  #     @guardian = Guardian.new(User.new)
  #     expect { @guardian.can_edit_journal? }.to raise_error(PermissionError)
  #   end

  #   it 'returns true when the user is the owner of hte contract' do 
  #     @guardian = Guardian.new(User.new)
  #     @guardian.can_edit_journal?.should eq(true)
  #   end

  #   it 'returns true when the user is an admin' do 
  #     @guardian = Guardian.new(Admin.new)
  #     @guardian.can_edit_journal?.should eq(true)
  #   end
  # end

end
