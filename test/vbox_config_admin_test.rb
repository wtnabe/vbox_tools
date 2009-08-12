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
    @obj.machines.each { |m|
      assert( @obj.backup_files( m ) == [] )
      @obj.create_backup( m )
      assert( @obj.backup_files( m ).size > 0 )
      @obj.clear_backups( m )
      assert( @obj.backup_files( m ) == [] )
    }
  end

  def test_backup_file
    @obj.machines.each { |m|
      assert( @obj.backup_file( m ).size > 0 )
    }
    assert( @obj.backup_file.size > 0 )
  end

  def test_backup_files
    # already tested in test_create_backup
  end

  def test_clear_backups
    # already tested in test_clear_backups
  end

  def test_open
    # don't know how to test
  end

  def test_open_config
    # don't know how to test
  end

  def test_open_latest_backup
    # don't know how to test
  end

  def 

  def test_getextradata
    @obj.machines.each { |m|
      assert( @obj.getextradata( m ).size > 0 )
    }
  end
end
