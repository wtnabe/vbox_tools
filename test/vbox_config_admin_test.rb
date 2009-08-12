#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'test/unit'
require File.dirname( __FILE__ ) + '/../lib/vbox_config_admin'

class Test_VboxConfigAdmin < Test::Unit::TestCase
  def setup
    @obj = VboxConfigAdmin.new
  end

  def test_version
    assert( @obj.version.size > 0 )
  end

  def test_machine_base
    assert( @obj.machine_base.size > 0 )
  end

  def test_vm_root
    assert( @obj.vm_root.class == String )
  end

  def test_machines
    assert( @obj.machines.class == Array )
  end

  def test_manager
    assert( @obj.manager.size > 0 )
  end

  def test_config_file
    @obj.machines.each { |m|
      assert( @obj.config_file( m ).size > 0 )
    }
    assert( @obj.config_file.size > 0 )
  end

  def test_create_backup
=begin

create_backup して backup_files があったら ok ?

=end
    assert( nil )
  end

  def test_backup_file
    @obj.machines.each { |m|
      assert( @obj.backup_file( m ).size > 0 )
    }
    assert( @obj.backup_file.size > 0 )
  end

  def test_backup_files
    assert( nil )
  end

  def test_clear_backups
    assert( nil )
  end

  def test_open
    assert( nil )
  end

  def test_open_config
    assert( nil )
  end

  def test_open_latest_backup
    assert( nil )
  end

  def 

  def test_getextradata
    @obj.machines.each { |m|
      assert( @obj.getextradata( m ).size > 0 )
    }
  end
end
